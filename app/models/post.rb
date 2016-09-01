class Post < ActiveRecord::Base
	after_create :send_email_to_subscribers

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :nested_comments, through: :comments, source: :children
	has_many :likes
	has_many :liked_by, through: :likes, source: :user
	
	validates :user_id, presence: true
	validates :content, presence: true

	has_attached_file :image,
	 styles: { small: "64x64", med: "100x100", large: "300x300" }
	validates_attachment :image,
	 	content_type: { content_type: ["image/jpg", "image/jpeg", "image/png",
	 															 "image/gif"] }
	 									
	ratyrate_rateable "content"

	acts_as_taggable_on :tags

	def self.search(search)
  	where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%") 
	end

	def to_param
    [id, title.parameterize].join("-")
  end

	private

	def send_email_to_subscribers
	  Subscriber.all.each do |subscriber|
	   SubscriptionMailer.send_email(subscriber.email, self).deliver_now
	  end
	end
end
