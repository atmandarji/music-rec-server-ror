class Users < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :created_at
  	remove_column :users, :updated_at
  	remove_column :users, :id
  	add_column :users, :userid, :string
  	add_column :users, :username, :string, null: false
  	add_column :users, :password, :string, null: false
  	execute "ALTER TABLE users ADD PRIMARY KEY (userid);"
  end
end
