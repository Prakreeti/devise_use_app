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
  	errors.add(:friend, "can't be equal to user") if user == friend
	end

  def not_friends
    errors.add(:friend, 'is already added') if user.friends.include?(friend)
  end
end
