class AddTotalSearchCountColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_search_count, :integer
  end
end
