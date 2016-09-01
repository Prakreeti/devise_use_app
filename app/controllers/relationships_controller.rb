class RelationshipsController < ApplicationController
	before_action :authenticate_user!

  #to create a follow relationship
  def create
    user = User.find_by(:id => params[:followed_id])
    current_user.follow(user)
    redirect_to :back
    flash[:notice] = "You are now following #{user.name}."
  end

  #to stop following someone
  def destroy
    user = Relationship.find_by(:id => params[:id]).followed
    current_user.unfollow(user)
    redirect_to :back
    flash[:notice] = "You unfollowed #{user.name}."
  end
end