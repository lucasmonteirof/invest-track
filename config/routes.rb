Rails.application.routes.draw do
  root to: "sessions#new"

  resources :users, only: [ :new, :create ]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  get "up" => "rails/health#show", as: :rails_health_check
end
