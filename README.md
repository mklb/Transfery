# README
The documentation is not 100% clear so this is what will happen:

- The user is able to send funds to users in a currency as long as he has enough founds in the currency (wallet)

- If the user has for example 100 USD and 0 EUR but wants to send 50 EUR to someone he has to make a transaction to himself first (from US to EUR). After that he can send the EUR to someone. btw: This is perfect for earning more money from transaction fees ;)

- Transfery can't create money out of thin air.. this is why the Transfery HQ User Account is created with a budget of 100.000 USD. This money is used for granting welcome presents to new users..(email: "All users start with 1000 USD.."). So a new user triggers a transaction from the Transfery HQ account to the new users account.

- The app uses the openexchangerates.org API for calculation exchange rates. It caches the results but sometimes exchange rates are just 1:1..I would investigate this issue but I have no more time left to code today. Fallback rates are implemented (`./config/initializers/money.rb`)

- The app is not optimized for mobile

## Setup
There are 4 default users available (details: `./db/seeds.rb`)

```
# make sure postgress is running and create the database as follows:
rails db:create db:migrate db:seed
# start the service
rails s
```