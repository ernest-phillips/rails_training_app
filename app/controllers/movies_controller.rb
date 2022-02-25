class MoviesController < ApplicationController
  def index
    movies = Movie.includes(:director)

    render locals: { movies: movies }
  end

  def show
    movie = Movie.find(params[:id])

    render locals: { movie: movie }
  end

  def new
    movie = Movie.new

    render locals: { movie: movie }
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      redirect_to movie
    else
      render "new", locals: { movie: movie }
    end
  end

  def edit
    movie = Movie.find(params[:id])

    render locals: { movie: movie }
  end

  def update
    movie = Movie.find(params[:id])

    if movie.update(movie_params)
      redirect_to movie
    else
      render "edit", locals: { movie: movie }
    end
  end

  def destroy
    movie = Movie.find(params[:id])

    if movie.destroy
      redirect_to movies_path
    else
      redirect_to movie_path(movie)
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director_name, :director_id, :year)
  end
end
