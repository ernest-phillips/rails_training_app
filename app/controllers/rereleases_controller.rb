class RereleasesController < ApplicationController
  def new
    movie = Movie.find(params[:movie_id])

    render locals: { movie: movie }
  end

  def create
    movie = Movie.find(params[:movie_id])

    rereleaser = Rereleaser.new(movie)

    rerelease = rereleaser.run(params[:rerelease])

    redirect_to movie_path(rerelease)
  end
end
