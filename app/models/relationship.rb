class FollowRelationship < ActiveRecord::Base
	belongs_to :user
  belongs_to :follow, class_name: 'User'
  belongs_to :follower, class_name: 'User'
end
