Rails.application.routes.draw do
  devise_for :users
  resources :reviews, only: [:index, :new, :create, :show] do
    resources :comments, only: [:create, :new]
    resources :likes, only: [:create, :destroy]
  end
  resources :tags do
    collection do 
      get :search
    end
  end
  root "reviews#index"
end
