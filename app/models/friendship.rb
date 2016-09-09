class Friendship < ActiveRecord::Base
	validate :not_self

	belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def not_self
  	errors.add(:friend, "can't be equal to user") if is_same_user?(user, friend)
	end

	def is_same_user?(user, friend)
    user == friend
  end
end
