Rails.application.routes.draw do
  get 'healths', to: 'healths#index'
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  
  resources :creators , except: [:update, :destroy]
  resources :gigs, except: [:destroy]
end
