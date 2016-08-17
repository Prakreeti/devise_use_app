class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	has_many :children, class_name: "Comment", foreign_key: "reply_to", dependent: :destroy
	belongs_to :parent, class_name: "Comment", foreign_key: "reply_to"
	has_many :comment_likes
	has_many :liked_by, through: :comment_likes, source: :user
	
	validates :user_id, presence: true
	validates :post_id, presence: true
	validates :content, presence: true
end
