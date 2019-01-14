class Histories < ActiveRecord::Migration[5.2]
  def change
  	remove_column :histories, :created_at
  	remove_column :histories, :updated_at
  	remove_column :histories, :id
  	add_column :histories, :userid, :string
  	add_column :histories, :keyword, :string
  	execute "ALTER TABLE histories ADD PRIMARY KEY (userid, keyword);"
  	execute "ALTER TABLE histories ADD FOREIGN KEY (userid) REFERENCES users (userid)"
  end
end
