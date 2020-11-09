Rails.application.routes.draw do
  devise_for :users
  get 'targets/index'
  root to: "targets#index"
end
