Rails.application.routes.draw do
  devise_for :users
  resources :reviews, only: [:index, :new, :create, :show]
  root "reviews#index"
end
