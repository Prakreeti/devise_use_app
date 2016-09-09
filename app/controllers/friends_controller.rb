class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend, only: :destroy

  #to show friends of the user
  def index
    @friends = current_user.friends.paginate(page: params[:page])
  end

  #to delete friends 
  def destroy
    if current_user.remove_friend(@friend)
      respond_to do |format|
        flash[:notice] = "Friend Deleted"
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  private

  def set_friend
    @friend = current_user.friends.find_by(id: params[:id])
  end
end
