class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :friend_requests, dependent: :destroy
  has_many :pending_requests, through: :friend_requests, source: :friend

  has_many :follow_relationships, class_name: "Relationship",
                              foreign_key: "follower_id", dependent: :destroy
  has_many :followed_relationships,  class_name: "Relationship",
                              foreign_key: "followed_id", dependent: :destroy
  has_many :follows, through: :follow_relationships, source: :followed
  has_many :followers, through: :followed_relationships, source: :follower

  has_many :likes, dependent: :destroy
  has_many :likes_post, through: :likes,
                        source: :post, dependent: :destroy
                        
  has_many :comment_likes, dependent: :destroy
  has_many :likes_comment, through: :comment_likes,
                           source: :comment, dependent: :destroy

  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100" }

  ratyrate_rater

  geocoded_by :address
  after_validation :geocode
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook],
         :authentication_keys => [:login]

  VALID_FB_REGEX = /(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-\.]*)/
  VALID_STRING_REGEX = /([\w\-\'])([\s]+)?([\w\-\'])/

  validates :name,  presence: true, 
    length: { maximum: 50 }, 
    format: { with: VALID_STRING_REGEX }, unless: :uid
  validates :city,  presence: true, format: { with: VALID_STRING_REGEX }, 
                    unless: :uid
  validates :username,  presence: true, uniqueness: true, unless: :uid
  validates :fb_profile, presence: true,
                    format: { with: VALID_FB_REGEX }, unless: :uid

  has_attached_file :avatar, :styles => { :medium => "300x300>",
                                          :thumb => "100x100#" },
                  :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # for facebook login
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

  #to make a user follow another user
  def follow(other_user)
    follow_relationships.create(followed_id: other_user.id)
  end

  #to stop user from following other user
  def unfollow(other_user)
    follow_relationships.find_by(followed_id: other_user.id).destroy
  end

  #for the feed to be shown in the dashboard
  def feed
    follow_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{follow_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def follow_relation(user)
    self.follow_relationships.find_by(followed_id: user)
  end

  def friendship(friend)
    self.friends.where(id: friend.id)
  end

  def friend_request(friend)
    self.friend_requests.find_by(friend_id: friend)
  end

  def has_friend?(friend)
    self.friends.where(id: friend.id).present?
  end

  def remove_friend(friend)
    self.friends.destroy(friend)
    friend.friends.destroy(self)
  end

  def has_sent_friend_request_to?(friend)
    self.friend_requests.find_by(friend_id: friend).present?
  end

  def is_following?(user)
    self.follows.include?(user)
  end

  def is_followed_by
    self.followers.count
  end

  def is_following
    self.follows.count
  end

  #Storing city as the address to be used by geocoder 
  def address
    "#{city}"
  end

  #to login using email or username
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  #to use friendly urls
  def to_param
    [id, name.parameterize].join("-")
  end
  
  #implements searching users 
  def self.search(search) 
    where("name LIKE :search  OR city LIKE :search", {search: "%#{search}%"})
  end
end
