Rails.application.routes.draw do
  get "/movies", to: "movies#index", as: "movies"
  post "/movies", to: "movies#create"
  get "/movies/new", to: "movies#new", as: "new_movie"
  get "/movies/:id", to: "movies#show", as: "movie"
  patch "/movies/:id", to: "movies#update"
  get "/movies/:id/edit", to: "movies#edit", as: "edit_movie"
  delete "/movies/:id", to: "movies#destroy"
  # post "/movies/:movie_id/rereleases" , to: "rereleases#create"

  resources :movies do
    resources :rereleases, only: [:create]
  end

  resources :directors
end
