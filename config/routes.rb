Rails.application.routes.draw do
  get 'page/index'

  resources :notes
  
  root to: "notes#index"
end
