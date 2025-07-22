Rails.application.routes.draw do
  root to: "home#index"

  resources :users, only: [ :new, :create ]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "up" => "rails/health#show", as: :rails_health_check
end
