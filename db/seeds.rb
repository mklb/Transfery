# the services owner 
a = User.create!(name: "Trasfery HQ", email: "hello@trasfery.com", password: "test123", terms: true)
# initial transaction "from our real bank account to our own system.."
Transaction.create!(
  sender_id: a.id,
  reciever_id: a.id,
  amount_send_cents: 0,
  currency_sender: "USD",
  amount_received_cents: 1000000,
  currency_reciever: "USD"
)
# users..
User.create!(name: "Patrick", email: "patrick@trasfery.com", password: "test123", terms: true)
User.create!(name: "Mathias", email: "mathias@trasfery.com", password: "test123", terms: true)
User.create!(name: "No Moeny Dude", email: "rnd1@trasfery.com", password: "test123", terms: true)
User.create!(name: "Wealthy Dude", email: "rnd2@trasfery.com", password: "test123", terms: true)