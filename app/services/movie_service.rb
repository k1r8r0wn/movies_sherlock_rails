class MovieService
  attr_reader :user, :title, :parser, :execute, :movie, :errors

  def initialize(user, title, parser)
    @user = user
    @title = title
    @parser = parser
    @execute = {}
    @errors = []
  end

  def save
    if user && user.movies.where(title: title).present?
      @movie = user.movies.find_by(title: title)
      increment_count
    elsif user
      @movie = Movie.find_or_create_by(parser.prepare_to_model)
      @movie.users << user
      increment_count
    else
      @movie = ShowMovieService.new(parser.prepare_to_model)
    end

    @execute = {command: 'render', arg: 'show'}
  end

  def errors?
    errors.present?
  end

  def increment_count
    @movie.increment!(:search_count)
    user.increment!(:total_search_count)
  end
end
