Rails.application.routes.draw do
  devise_for :users
  resources :reviews, only: [:index, :new, :create, :show] do
    resources :comments, only: [:create, :new]
  end
  root "reviews#index"
end
