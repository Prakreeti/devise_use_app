class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]

  #create a new friend request
  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)
    @friend_request.save
    redirect_to :back
 	end

  #to list all incoming and outgoing friend requests
 	def index
	  @incoming = FriendRequest.where(friend: current_user)
	  @outgoing = current_user.friend_requests
	end

  #to destroy friend request
	def destroy
  	@friend_request.destroy
    redirect_to :back
  end

  #to acccept friend request
  def update
  	@friend_request.accept
    redirect_to :back
	end

	#def not_self
  #	errors.add(:friend, "can't be equal to user") if user == friend
	#end

 	private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
