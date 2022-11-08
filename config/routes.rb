Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  
  resources :creators , except: [:update, :destroy]
  resources :gigs, except: [:destroy]
end
