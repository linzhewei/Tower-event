Rails.application.routes.draw do
  devise_for :users
  root "teams#index"

  resources :teams, only: [:index, :new, :show, :create] do
    resources :projects, only: [:show, :new, :create] do
      resources :todos do
        member do
          post :run
          post :pause
          post :finish
          post :delete
          post :reopen
          post :recover
        end
        resources :comments, only: [:new, :create]
      end
    end
  end
end
