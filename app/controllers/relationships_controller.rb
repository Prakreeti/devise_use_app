class RelationshipsController < ApplicationController
	before_action :authenticate_user!

  #to create a follow relationship
  def create
    @user = User.find_by(id: params[:followed_id])
    if current_user.follow(@user)
      respond_to do |format|
        flash[:notice] = "You followed #{@user.name}."
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  #to stop following someone
  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    if current_user.unfollow(@user)
      respond_to do |format|
          flash[:notice] = "You unfollowed #{@user.name}."
          format.html {redirect_to :back}
          format.js 
      end
    end   
  end
end