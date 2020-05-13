Rails.application.routes.draw do
  devise_for :users
  resources :blogs
  resources :favourites
  resources :topic
end
