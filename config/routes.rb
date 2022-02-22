Rails.application.routes.draw do
  resources :movies do
    resources :rereleases, only: [:new, :create]
  end

  resources :directors
end
