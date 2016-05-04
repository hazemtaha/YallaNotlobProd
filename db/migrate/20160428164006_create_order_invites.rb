class CreateOrderInvites < ActiveRecord::Migration
  def change
    create_table :order_invites do |t|
      t.integer :invite_status, limit: 1, default: 0
      t.references :user, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
