class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)
    @friend_request.save
    redirect_to users_path
 	end

 	def index
	  @incoming = FriendRequest.where(friend: current_user)
	  @outgoing = current_user.friend_requests
	end

	def destroy
  	@friend_request.destroy
    redirect_to users_path
  end

  def update
  	@friend_request.accept
    redirect_to friend_requests_path
	end

	def not_self
  	errors.add(:friend, "can't be equal to user") if user == friend
	end

 	private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
