class ParserService
  attr_reader :result

  def initialize
    @result = nil
  end

  def find_movie(movie_title)
    @result = prepare_data(movie_title)
  end

  def prepare_to_model
    info =
        { film_type: result['Type'],
          imbd_rating: result['imdbRating'],
          imbd_votes: result['imbdVotes'],
          imbd_id: result['imbdID']
        }
    %i(title year rated released runtime genre director writer actors plot
   language country awards poster metascore response error).each do |key|
      info[key] = result[key.to_s.capitalize]
    end
    info
  end

  private

  def prepare_data(movie_title)
    api_result = RestClient.get 'http://www.omdbapi.com/?t=' + movie_title + '&y=&plot=full&r=JSON'
    JSON.parse(api_result)
  end
end
