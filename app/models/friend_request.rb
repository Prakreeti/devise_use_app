class FriendRequest < ActiveRecord::Base
	belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :not_self
  validate :not_friends

  def accept
    user.friends << friend
    friend.friends << user
    destroy
  end

	private

	def not_self
  	errors.add(:friend, "can't be equal to user") if is_same_user?(user, friend) 
	end

  def is_same_user?(user, friend)
    user == friend
  end

  def not_friends
    errors.add(:friend, 'is already added') if user.has_friend?(friend)
  end  
end
