class Reply < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	belongs_to :comment
	validates :content, presence: true
	validates :user_id, presence: true
	validates :post_id, presence: true
	validates :comment_id, presence: true
end
