class RereleasesController < ApplicationController
  def create
    original_movie = Movie.find(params[:movie_id])
    
    rerelease = move.create_rerelease(year: params[:year])
    
    redirect_to movie_path(rerelease)
  end  
end