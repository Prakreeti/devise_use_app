class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, except: [:index, :create]

  #create a new friend request
  def create
    @friend = User.find_by(id: params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: @friend)
    if @friend_request.save
      respond_to do |format|
        flash[:notice] = "Friend Request sent."
        format.html {redirect_to :back}
        format.js
      end
    end
 	end

  #to list all incoming and outgoing friend requests
 	def index
	  @incoming = FriendRequest.where(friend: current_user)
	  @outgoing = current_user.friend_requests
	end

  #to destroy friend request
	def destroy
    if @friend_request.destroy
      respond_to do |format|
        flash[:notice] = "Friend Request Deleted"
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  #to acccept friend request
  def update
  	if @friend_request.accept
      respond_to do |format|
        flash[:notice] = "Friend Request Accepted"
        format.html {redirect_to :back}
        format.js
      end
    end
	end

 	private

  def set_friend_request
    @friend_request = FriendRequest.find_by(id: params[:id])
  end
end
