class Transaction < ApplicationRecord
  # default currency
  register_currency :usd
  monetize :amount_send_cents, with_model_currency: :currency_sender
  monetize :amount_received_cents, with_model_currency: :currency_reciever

  validates :sender, presence: true
  validates :reciever, presence: true
  validates :amount_send_cents, presence: true
  validates :amount_received_cents, presence: true
  validates :currency_sender, presence: true
  validates :currency_reciever, presence: true

  belongs_to :sender, class_name: "User"
  belongs_to :reciever, class_name: "User"

  # this is where we allow new currencies
  enum currencies: ["USD", "EUR", "GBP"]
end
