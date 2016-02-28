class ChangeColumnsNames < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.rename :imbd_votes, :imdb_votes
      t.rename :imbd_rating, :imdb_rating
      t.rename :imbd_id, :imdb_id
    end
  end
end
