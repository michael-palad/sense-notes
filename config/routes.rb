Rails.application.routes.draw do
  devise_for :users
  get 'page/index'

  authenticated :user do
    resources :notes
    root to: "notes#index", as: :notes_root
  end
  
  root to: "page#index"
end
