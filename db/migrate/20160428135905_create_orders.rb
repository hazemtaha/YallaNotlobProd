class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :destination, limit: 100, null: false
      t.string :menu_img, limit: 200
      t.integer :order_type, limit: 1, null: false
      t.integer :status, limit: 1, default: 1
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
