Rails.application.routes.draw do
  resources :movies do
    resources :rereleases, only: [:new, :create]
  end

  resources :directors

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
end
