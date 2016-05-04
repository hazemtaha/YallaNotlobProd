class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :username, :string, null: false
  	add_column :users, :gender, :string, null: false
  end
end
