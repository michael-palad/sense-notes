Rails.application.routes.draw do
  devise_for :users
  get 'page/index'

  resources :notes
  
  root to: "page#index"
end
