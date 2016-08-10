class Post < ActiveRecord::Base
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
	
end
