class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, :dependent => :delete_all
  has_many :order_invites, :dependent => :delete_all
  enum status: { Waiting: 1, Finished: 0}
  enum order_type: { Breakfast: 1, Lunch: 2, Dinner: 3}
  mount_uploader :menu_img, ImageUploader
  validates :destination, presence: true
  validates :menu_img, presence: true
  default_scope { order('created_at DESC') }
end
