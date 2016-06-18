require 'rails_helper'
require 'yaml'

describe ParserService do

  context 'output not contain errors' do
    it 'finds the movie' do
      movie_data = YAML.load_file("#{::Rails.root}/spec/fixtures/services/movie_hash.yml")

      parser = ParserService.new
      allow_any_instance_of(ParserService).to receive(:prepare_data).with('film_name') { movie_data['movie'] }

      movie_title = 'film_name'
      result = parser.find_movie(movie_title)
      p parser.result
      expect(result).to_not be_nil
    end

    it 'prepares to model' do
      movie_data = YAML.load_file("#{::Rails.root}/spec/fixtures/services/movie.yml")

      parser = ParserService.new
      allow(parser).to receive(:prepare_data) { JSON.parse(movie_data['movie']) }

      movie_title = 'film_name'
      result = parser.find_movie(movie_title)
      p parser.prepare_to_model
      expect(result).to_not be_nil
    end
  end

  context 'output contain errors' do
    # movie_data = YAML.load_file("#{::Rails.root}/spec/fixtures/services/movie_error.yml")
    #
    # parser = ParserService.new
    # allow(parser).to receive(:prepare_data) { JSON.parse(movie_data['movie']) }
    #
    # movie_title = 'film_name'
    # result = parser.find_movie(movie_title)
    # p parser.prepare_to_model
    #
    # expect(flash[:alert]).to eq('There ')
  end
end
