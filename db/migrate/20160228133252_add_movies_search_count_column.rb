class AddMoviesSearchCountColumn < ActiveRecord::Migration
  def change
    add_column :movies, :search_count, :integer
  end
end
