class RereleasesController < ApplicationController
  def create
    movie = Movie.find(params[:movie_id])

    rerelease = movie.rerelease(params)

    redirect_to movie_path(rerelease)
  end
end
