Rails.application.routes.draw do
  root "posts#index"
  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  get 'logout', to: "sessions#delete", as: :logout
  resources :posts do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
