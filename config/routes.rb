Rails.application.routes.draw do
  get "/", to: "blogs#index", as: "root"
  devise_for :users
  resources :blogs
  resources :favourites
  resources :topic
end
