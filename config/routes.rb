Rails.application.routes.draw do
  devise_for :users
  root to: "targets#index"
  resources :targets, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :achieves, only: [:create, :destroy]
    resources :fights, only: [:create, :destroy]
  end
end
