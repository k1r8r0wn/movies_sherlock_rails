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
      @movie = Movie.find_by(title: title, id: user.movies)
      @movie.increment!(:search_count)
      user.increment!(:total_search_count)
    elsif user
      @movie = Movie.find_or_create_by(parser.prepare_to_model) do |m|
        m.users << user
        m.increment!(:search_count)
      end
      user.increment!(:total_search_count)
    else
      @movie = ShowFilm.new(parser.prepare_to_model)
    end

    @execute  = {command: 'render', arg: 'show'}
  end

  def errors?
    errors.present?
  end
end