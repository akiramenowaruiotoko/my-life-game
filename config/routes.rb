Rails.application.routes.draw do
  devise_for :users
  root to: "targets#index"
  resources :targets, only: [:new, :create, :show, :edit, :update, :destroy]
end
