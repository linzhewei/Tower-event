Rails.application.routes.draw do
  devise_for :users
  root "teams#index"

  resources :teams, only: [:index, :new, :show, :create] do
    resources :projects, only: [:show, :new, :create] do
      resources :todos
    end
  end
end
