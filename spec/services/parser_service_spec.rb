require 'rails_helper'
require 'yaml'

describe ParserService do
  context 'parse movie data' do
    it 'should not be nil' do
      parser = ParserService.new
      movie_json_data = YAML.load_file("#{::Rails.root}/spec/fixtures/services/movie.yml")
      allow(parser).to receive(:prepare_data) { JSON.parse(movie_json_data['movie']) }

      movie_title = ''
      result = parser.find_movie(movie_title)

      expect(result).to_not be_nil
    end
  end
end
