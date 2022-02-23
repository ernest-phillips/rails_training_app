class RereleasesController < ApplicationController
  def new
    movie = Movie.find(params[:movie_id])

    render locals: { movie: movie }
  end

  def create
    movie = Movie.find(params[:movie_id])

    rereleaser = Rereleaser.new(movie)

    rerelease = rereleaser.run(rerelease_params)

    redirect_to movie_path(rerelease)
  end

  private

  def rerelease_params
    params.require(:rerelease).permit(:year)
  end
end
