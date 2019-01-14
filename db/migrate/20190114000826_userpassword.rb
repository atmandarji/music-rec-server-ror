class Userpassword < ActiveRecord::Migration[5.2]
  def change
  	execute "DELETE FROM histories"
  	execute "DELETE FROM users"
  	remove_column :users, :password 
  	add_column :users, :password_hash, :string, null: false
  	add_column :users, :password_salt, :string, null: false
  end
end
