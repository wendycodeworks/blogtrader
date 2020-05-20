Rails.application.routes.draw do
  get "/", to: "blogs#index", as: "root"
  devise_for :users
  resources :blogs
  resources :favourites
  resources :topic
  get "/manage", to: "blogs#manage", as: "manage_listings"
  #--------------------------------------------------------
  # Stripe routes
  #--------------------------------------------------------
  get "/payments/success", to: "payments#success"
  post "/payments/webhook", to: "payments#webhook"
end
