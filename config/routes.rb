Rails.application.routes.draw do
  resources :authors
  resources :books
  resources :libraries
  devise_for :users
  root to: "home#index"
  get 'home/index'
end
