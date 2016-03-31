class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :vote_for, :vote_against]
  before_action :movie_title_exists?, only: [:create]
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
    parser = ParserService.new
    parser.find_movie(@movie_title)

    if parser.contain_errors?
      flash.now[:error] = "Sorry, but there is no results for \"#{@movie_title}\"."
      render :index
    else
      movie_service = MovieService.new(current_user, @movie_title, parser)
      movie_service.save
      if movie_service.errors.present?
        flash[:error] = movie_service.errors.join(' ')
      else
        @movie = movie_service.movie
      end

      send(movie_service.execute[:command], movie_service.execute[:arg])
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
    authorize @movie
    if true
      redirect_to :back, success: 'You successfully delete your vote!'
    else
      redirect_to :back, error: 'Oops, something goes wrong!'
    end
  end

  def search
    authorize :movie, :search?
    if params[:search].blank?
      redirect_to :back, notice: 'Oops, nothing to search. What would you like to find?'
    else
      @query = Sunspot.search(Movie) do
        fulltext params[:search] do
          fields(:title)
        end
      end
      @movies = @query.results

      if @movies.empty?
        redirect_to :back, notice: 'There is no results. Please, try another search.'
      else
        render :search
      end
    end
  end

  private

  def set_movie
    @movie = Movie.friendly.find(params[:id])
  end

  def movie_title_exists?
    @movie_title = params[:movie_title]
    if @movie_title.empty?
      flash.now[:error] = 'Oops, nothing to search!'
      render :index
    elsif @movie_title.match(/[\p{L}&&[^a-zA-Z]]/)
      flash.now[:error] = 'Please, use only ASCII characters.'
      render :index
    end
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
