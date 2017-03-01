Rails.application.routes.draw do
  devise_for :users
  root "welcome#index"

  resources :teams, only: [:index, :new, :show, :create]
end
