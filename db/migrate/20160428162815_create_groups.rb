class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, limit: 50
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
