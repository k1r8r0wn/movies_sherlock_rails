class VideosController < ApplicationController
  after_action :verify_authorized

  def add
    @movie = Movie.friendly.find(params[:id])
    authorize @movie
    if params[:movie] && params[:movie][:video]
      @movie.update_attribute(:video, params[:movie][:video])
      flash[:success] = 'Movie trailer is successfully added!'
    else
      flash[:notice] = 'Oops, there is nothing to add!'
    end
    redirect_to movie_path(@movie)
  end
end
