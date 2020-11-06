Rails.application.routes.draw do
  get 'targets/index'
  root to: "targets#index"
end
