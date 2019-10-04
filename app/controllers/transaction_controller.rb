class TransactionController < ApplicationController
  before_action :authenticate_user!
  before_action :balance, only: [:welcome, :new]

  def welcome
  end

  def new
    @transaction = Transaction.new
    @possible_receivers = User.all
  end

  def create
    amount_send_cents = transaction_params["amount_send_cents"].to_f * 100
    if !transaction_params["receiver"].empty? && 
       amount_send_cents > 0.0 && 
       current_user.send_money(
         transaction_params["receiver"],
         amount_send_cents,
         transaction_params["currency_sender"],
         transaction_params["currency_reciever"],
        )
      redirect_to user_root_path, notice: 'Transaction complete' 
    else
      redirect_to :new_transaction, notice: 'Transaction failed' 
    end
  end

  private
    def transaction_params
      params.permit(:receiver, :amount_send_cents, :currency_sender, :currency_reciever)
    end

    def balance
      @balance = current_user.bank_balance
    end
end
