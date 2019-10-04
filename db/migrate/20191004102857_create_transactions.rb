class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :sender, null: false
      t.references :reciever, null: false
      t.bigint :amount_send_cents
      t.bigint :amount_received_cents
      t.string :currency_sender
      t.string :currency_reciever

      t.timestamps
    end
  end
end
