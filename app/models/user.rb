class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, :dependent => :delete_all       
  has_many :order_items, :dependent => :delete_all
  has_many :friendships, :dependent => :delete_all
  has_many :friends, :through => :friendships
  has_many :groups, :dependent => :delete_all
  has_many :group_members, :dependent => :delete_all
  has_many :order_invites, :dependent => :delete_all
  mount_uploader :image, ImageUploader
  devise :omniauthable, :omniauth_providers => [:facebook,:google_oauth2]

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    
    #user.id = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.username = auth.info.name   # assuming the user model has a name
    puts auth.extra
    puts "HELLOOOOOOOOOOOOOOOOO"
    if(auth.extra.raw_info.gender == "male" or !auth.extra.raw_info.gender)
      user.gender = 0
    elsif(auth.extra.raw_info.gender == "female")
      user.gender = 1
    end 
    user.remote_image_url = auth.info.image.gsub('http://','https://')
    user.provider = auth.provider
    user.save!
  end
end

def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
