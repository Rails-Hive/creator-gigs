Rails.application.routes.draw do
  resources :creators , except: [:update, :destroy]
  resources :gigs, except: [:destroy]
end
