class AddAnotherFieldToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :image, :string, null: false
  end
end
