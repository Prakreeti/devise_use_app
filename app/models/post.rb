class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :nested_comments, through: :comments, source: :children
	
	validates :user_id, presence: true
	validates :content, presence: true
end
