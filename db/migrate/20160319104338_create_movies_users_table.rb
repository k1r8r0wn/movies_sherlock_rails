class CreateMoviesUsersTable < ActiveRecord::Migration
  def change
    create_table :movies_users, id: false do |t|
      t.references :movie, index: true
      t.references :user, index: true
    end
  end
end
