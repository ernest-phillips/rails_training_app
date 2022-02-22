class RereleasesController < ApplicationController
  def create
    movie = Movie.find(params[:movie_id])

    rereleaser = Rereleaser.new(movie)

    rerelease = rereleaser.run(params)

    redirect_to movie_path(rerelease)
  end
end
