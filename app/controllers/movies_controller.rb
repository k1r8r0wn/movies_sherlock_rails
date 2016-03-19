class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :vote_for, :vote_against]
  after_action :verify_authorized, only: [:show, :vote_for, :vote_against]

  def index; end

  def show
    set_movie
    authorize @movie
    if @movie.users.where(id: current_user.id).present?
      render :show
    else
      redirect_to my_movies_path, notice: "You haven't got movie with this id."
    end
  end

  def create
    @movie_title = params[:movie_title]
    if @movie_title.empty?
      flash.now[:error] = 'Oops, nothing to search!'
      render :index
    elsif @movie_title.match(/[\p{L}&&[^a-zA-Z]]/)
      flash.now[:error] = 'Please, use only ASCII characters.'
      render :index
    else
      parser = ParserService.new
      parser.find_movie(@movie_title)
      parser_result = parser.result

      if parser_result['Title'].nil?
        flash.now[:error] = "Sorry, but there is no results for \"#{@movie_title}\"."
        render :index

      elsif current_user && current_user.movies.where(title: parser_result['Title']).present?
        @movie = Movie.friendly.find_by(title: parser_result['Title'], id: current_user.movies)
        @movie.increment!(:search_count)
        render :show

      elsif current_user
        @movie = Movie.new(parser.prepare_to_model)
        @movie.users << current_user

        if @movie.save
          @movie.increment!(:search_count)
          render :show
        else
          flash.now[:error] = 'Something goes wrong!'
          render :index
        end

      else
        @movie = ShowFilm.new(parser.prepare_to_model)
        render :show
      end
    end
  end

  def vote_for
    current_user.vote_for(set_movie)
    voted?
  end

  def vote_against
    current_user.vote_against(set_movie)
    voted?
  end

  def unvote
    current_user.unvote_for(set_movie)
  end

  private

  def set_movie
    @movie = Movie.friendly.find(params[:id])
  end

  def voted?
    authorize @movie
    if @movie.voted_by?(current_user)
      redirect_to :back, success: 'You vote is accepted!'
    else
      redirect_to :back, error: 'Oops, something goes wrong!'
    end
  end
end
