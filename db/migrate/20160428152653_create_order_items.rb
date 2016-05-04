class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :user, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.string :item, limit: 100
      t.integer :amount, limit: 1
      t.decimal :price
      t.string :comment, limit: 255

      t.timestamps null: false
    end
  end
end
