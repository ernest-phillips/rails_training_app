class RereleasesController < ApplicationController
  def new
    movie = Movie.find(params[:movie_id])

    rerelease = Rerelease.new(movie, {})

    render locals: { rerelease: rerelease }
  end

  def create
    movie = Movie.find(params[:movie_id])

    rerelease = Rerelease.new(movie, rerelease_params)

    if rerelease.save
      redirect_to movie_path(rerelease.id)
    else
      render "new", locals: { rerelease: rerelease }
    end
  end

  private

  def rerelease_params
    params.require(:rerelease).permit(:year)
  end
end
