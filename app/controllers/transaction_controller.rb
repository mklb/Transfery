class TransactionController < ApplicationController
  before_action :authenticate_user!

  def welcome
    @balance = current_user.bank_balance
  end

  def new
    @balance = current_user.bank_balance
    @transaction = Transaction.new
    @possible_receivers = User.all
  end

  def create
    print "_------------------------"
    print transaction_params["receiver"]
    if current_user.send_money(
      transaction_params["receiver"],
      transaction_params["amount_send_cents"].to_f * 100,
      transaction_params["currency_sender"],
      transaction_params["currency_reciever"],
    )
      redirect_to user_root_path, notice: 'DONE' 
    else
      redirect_to :new_transaction
    end
  end

  private
    def transaction_params
      params.permit(:receiver, :amount_send_cents, :currency_sender, :currency_reciever)
    end
end
