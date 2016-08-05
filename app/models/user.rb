class User < ActiveRecord::Base

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :friend_requests, dependent: :destroy
  has_many :follow_relationships, dependent: :destroy
  has_many :follows, through: :follow_relationships
  has_many :followers,through: :follow_relationships
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  VALID_FB_REGEX = /(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-\.]*)/
  VALID_STRING_REGEX = /([\w\-\'])([\s]+)?([\w\-\'])/

  validates :name,  presence: true, 
    length: { maximum: 50 }, 
    format: { with: VALID_STRING_REGEX }, unless: :uid
  validates :city,  presence: true, format: { with: VALID_STRING_REGEX },  unless: :uid
  validates :username,  presence: true, uniqueness: true, unless: :uid
  validates :fb_profile, presence: true,
                    format: { with: VALID_FB_REGEX }, unless: :uid

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name 
      user.confirmed_at = Time.now
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
