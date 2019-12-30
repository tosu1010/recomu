Rails.application.routes.draw do
  devise_for :users
  resources :albums, only: [:index, :show]

  resources :reviews, only: [:index, :new, :create, :show] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :new]
  end
  resources :tags do
    collection do 
      get :search
    end
  end
  root "albums#index"
end
