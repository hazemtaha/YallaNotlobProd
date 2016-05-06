class OrderItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  default_scope { order('created_at DESC') }
  validates :item, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  
end
