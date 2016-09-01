class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, except: [:index, :create]

  #create a new friend request
  def create
    friend = User.find_by(:id => params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)
    if @friend_request.save
      flash[:notice] = "Friend Request Sent"
    else
      flash[:notice] = "Friend Request not sent"
    end
    redirect_to :back
 	end

  #to list all incoming and outgoing friend requests
 	def index
	  @incoming = FriendRequest.where(friend: current_user)
	  @outgoing = current_user.friend_requests
	end

  #to destroy friend request
	def destroy
    if @friend_request.destroy
      flash[:notice] = "Friend Request Deleted"
    else
      flash[:notice] = "Friend Request not Deleted"
    end
    redirect_to :back
  end

  #to acccept friend request
  def update
  	@friend_request.accept
    redirect_to :back
	end

 	private

  def set_friend_request
    @friend_request = FriendRequest.find_by(:id => params[:id])
  end
end
