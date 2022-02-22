class RereleasesController < ApplicationController
  def create
    movie = Movie.find(params[:movie_id])

    rerelease = movie.dup
    rerelease.year = params[:year]
    rerelease.save

    redirect_to movie_path(rerelease)
  end
end
