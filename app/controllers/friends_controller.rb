class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend, only: :destroy

  #to create friends on acceptance of friend request
  def index
    @friends = current_user.friends.paginate(page: params[:page])
  end

  #to delete friends 
  def destroy
    current_user.friends.destroy(@friend)
    @friend.friends.destroy(current_user)
    redirect_to :back
  end

  private

  def set_friend
    @friend = current_user.friends.find_by(:id => params[:id])
  end
end
