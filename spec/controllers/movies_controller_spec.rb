require 'rails_helper'
require 'yaml'

describe MoviesController, type: :controller do

  before do
    movie_json_data = YAML.load_file("#{::Rails.root}/spec/fixtures/services/movie_hash.yml")

    @parser = ParserService.new
    allow_any_instance_of(ParserService).to receive(:prepare_data).with('film_name') { movie_json_data['movie'] }
    allow_any_instance_of(ParserService).to receive(:prepare_to_model) { movie_json_data['movie'] }

  end

  describe 'POST #create' do
    it 'finds the movie' do
      movie_title = 'film_name'
      result = @parser.find_movie(movie_title)
      p result
      expect(result).to_not be_nil
    end

    it 'renders redirects & show flash[:error]' do

    end
  end

end
