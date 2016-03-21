ActiveAdmin.register Movie do
  permit_params :title, :year, :rated, :released, :runtime, :genre, :director, :writer, :actors, :plot, :language, :country, :awards, :poster, :metascore, :imdb_rating, :imdb_votes, :imdb_id, :film_type, :response, :error, :created_at, :updated_at, :search_count, :slug

  index do
    selectable_column
    id_column
    column :title
    column :year
    column :rated
    column :released
    column :runtime
    column :genre
    column :director
    column :writer
    column :actors
    column :plot
    column :language
    column :country
    column :awards
    column :poster
    column :metascore
    column :imdb_rating
    column :imdb_votes
    column :imdb_id
    column :film_type
    column :response
    column :error
    column :created_at
    column :updated_at
    column :search_count
    column :slug
    actions
  end

  filter :title
  filter :year
  filter :rated
  filter :released
  filter :runtime
  filter :genre
  filter :director
  filter :writer
  filter :actors
  filter :plot
  filter :language
  filter :country
  filter :awards
  filter :poster
  filter :metascore
  filter :imdb_rating
  filter :imdb_votes
  filter :imdb_id
  filter :film_type
  filter :response
  filter :error
  filter :created_at
  filter :updated_at
  filter :search_count
  filter :slug

  form do |f|
    f.inputs "Movies" do
      f.inputs :title
      f.inputs :year
      f.inputs :rated
      f.inputs :released
      f.inputs :runtime
      f.inputs :genre
      f.inputs :director
      f.inputs :writer
      f.inputs :actors
      f.inputs :plot
      f.inputs :language
      f.inputs :country
      f.inputs :awards
      f.inputs :poster
      f.inputs :metascore
      f.inputs :imdb_rating
      f.inputs :imdb_votes
      f.inputs :imdb_id
      f.inputs :film_type
      f.inputs :response
      f.inputs :error
      f.inputs :created_at
      f.inputs :updated_at
      f.inputs :search_count
      f.inputs :slug
    end
    f.actions
  end
end
