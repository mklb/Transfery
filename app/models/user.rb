class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates_acceptance_of :terms, :allow_nil => false, :message => "not accepted", :on => :create

  after_create :grant_welcome_money

  def able_to_make_transaction?(amount, currency)
    amount = Money.new(amount, currency)
    balance = bank_balance[currency]
    return balance > 0 && amount <= balance
  end

  # returns an object holding each amount of each currency owned
  # {"USD"=>#<Money fractional:11900 currency:USD>, "EUR"=>#<Money fractional:0 currency:EUR>, "GBP"=>#<Money fractional:0 currency:GBP>}
  def bank_balance
    walletes = {}
    for t in Transaction.currencies.keys
      walletes[t] = Money.new(0, t)
    end

    for t in self.transactions
      if t.sender == self 
        # negative transaction
        walletes[t.currency_sender.upcase] -= t.amount_send
        if t.reciever == self
          walletes[t.currency_reciever.upcase] += t.amount_received
        end
      else
        # positive transaction
        walletes[t.currency_reciever.upcase] += t.amount_received
      end
    end

    return walletes
  end

  def send_money(receiver_id, amount_send_cents, currency_sender, currency_reciever)
    if self.able_to_make_transaction?(amount_send_cents, currency_sender)
      # create money object
      amount_received = Money.new(amount_send_cents, currency_sender)
      # check if we need to calc an exchange
      amount_received = amount_received.exchange_to(currency_reciever) if currency_sender =! currency_reciever

      a = Transaction.create!(
        sender_id: self.id,
        reciever_id: receiver_id,
        amount_send_cents: amount_send_cents,
        currency_sender: amount_received.currency,
        amount_received_cents: amount_received.cents,
        currency_reciever: currency_reciever
      )

      return true
    else
      return false
    end
  end

  def grant_welcome_money
    Transaction.create(
      sender: User.find(1),
      reciever: self,
      amount_send_cents: 10000,
      amount_received_cents: 10000,
      currency_sender: "usd",
      currency_reciever: "usd"
    )
  end

  def transactions
    Transaction.where("sender_id = ? OR reciever_id = ?", self.id, self.id).distinct
  end

end
