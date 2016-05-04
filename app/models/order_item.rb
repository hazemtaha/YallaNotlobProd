class OrderItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  default_scope { order('created_at DESC') }
  validates :item, presence: true
  validates :amount, presence: true
  validates :price, presence: true

end
