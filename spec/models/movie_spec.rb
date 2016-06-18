require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:valid_attributes) {
    {
      title: 'Movie',
      year: 'Year',
      rated: 'Rating',
      released: 'Date',
      runtime: 'Time',
      genre: 'Genre',
      director: 'Director',
      writer: 'Writer',
      actors: 'Actors',
      plot: 'Plot',
      language: 'Language',
      country: 'Country',
      awards: 'Awards',
      poster: 'Poster',
      metascore: 'Metascore',
      imdb_rating: 'Rating',
      imdb_votes: 'Votes',
      imdb_id: 'ID',
      film_type: 'Type',
      response: 'True',
      error: 'No'
    }
  }

  context 'relationships' do
    it { should have_and_belong_to_many(:users) }
  end

  context 'validations' do
    let(:movie) { Movie.new(valid_attributes) }

    before do
      Movie.create(valid_attributes)
    end

    it 'requires a movie title' do
      expect(movie).to validate_presence_of(:title)
    end
  end
end
