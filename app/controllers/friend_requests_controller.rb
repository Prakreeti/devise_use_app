class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)
    if @friend_request.save
      flash[:notice] = "Friend Request Sent"
      redirect_to users_path
    else
      flash[:notice] = "Friend Request Not Sent"
      redirect_to users_path
    end
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
