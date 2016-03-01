class MoviesController < ApplicationController
  before_filter :authenticate_user!, only: [:show]

  def index; end

  def new; end

  def show
    @movie = Movie.find(params[:id])
    if @movie.user_id == current_user.id
      render :show
    else
      redirect_to my_movies_user_path, notice: "You haven't got movie with this id."
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

      elsif current_user && Movie.where(title: parser_result['Title'], user_id: current_user.id).present?
        @movie = Movie.find_by(title: parser_result['Title'], user_id: current_user.id)
        @movie_id = @movie.id
        @movie.increment!(:search_count)
        render :show

      elsif current_user
        @movie = Movie.new(parser.prepare_to_model)
        @movie.user_id = current_user.id

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
end
