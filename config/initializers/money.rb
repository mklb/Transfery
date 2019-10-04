require 'money/bank/open_exchange_rates_bank'

OXR_CACHE_KEY = "#{Rails.env}:money:exchange_rates".freeze
# ExchangeRate is an ActiveRecord model
# more info at https://github.com/RubyMoney/money#exchange-rate-stores
oxr = Money::Bank::OpenExchangeRatesBank.new()
oxr.ttl_in_seconds = 86400
oxr.cache = Proc.new do |text|
  if text
    # only expire when refresh_rates is called or `force_refresh_rate_on_expire`
    # option is enabled
    # you can also set `expires_in` option on write to force fetch new rates
    Rails.cache.write(OXR_CACHE_KEY, text)
  else
    Rails.cache.read(OXR_CACHE_KEY)
  end
end
# TODO: delete demo account since this key is public ;)
oxr.app_id = "bf3501a27de6498f9bcbd2607762125c"
oxr.show_alternative = true
oxr.prettyprint = false
oxr.update_rates

MoneyRails.configure do |config|
  config.default_bank = oxr
  # fallback
  config.add_rate "USD", "GBP", 0.81
  config.add_rate "USD", "EUR", 0.91
  config.add_rate "GBP", "EUR", 1.12
  config.add_rate "GBP", "USD", 1.23
  config.add_rate "EUR", "USD", 1.1
  config.add_rate "EUR", "GBP", 0.89
end