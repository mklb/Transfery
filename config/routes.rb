Rails.application.routes.draw do
  # static landingpage
  root to: 'static#home'

  # first screen a user sees after he is logged in
  get '/welcome', to: 'transaction#welcome', as: :user_root
  get '/money', to: 'transaction#new', as: :new_transaction
  post '/send', to: 'transaction#create', as: :transaction

  # static paths
  get '/terms', to: 'static#terms', as: :terms
  get '/imprint', to: 'static#imprint', as: :imprint
  get '/privacy', to: 'static#privacy', as: :privacy
  get '/faq', to: 'static#faq', as: :faq

  # auth related routes
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
end
