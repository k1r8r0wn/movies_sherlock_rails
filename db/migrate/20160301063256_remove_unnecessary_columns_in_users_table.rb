class RemoveUnnecessaryColumnsInUsersTable < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest, :string
    remove_column :users, :password_reset_token, :string
    remove_column :users, :user_role, :string
  end
end
