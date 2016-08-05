class FollowRelationshipsController < ApplicationController
	before_action :set_follow_relationship, except: [:index, :create]

  def create
    follow = User.find(params[:follow_id])
    @follow_relationship = current_user.follow_relationships.new(follow: follow)
    @follower_relationship = follow.follow_relationships.new(follower: current_user )
    if @follow_relationship.save
    	@follower_relationship.save
      redirect_to users_path
    else
      redirect_to users_path
    end
  end
  def index
  	@following = FollowRelationship.where(user: current_user)
  	@followed = FollowRelationship.where(follow: current_user)
	end
	def destroy
		@follow_relationship.destroy
		@follow_relationship = FollowRelationship.find_by(:user => @follow_relationship.follow_id,
																						 :follower => @follow_relationship.user_id)
  	redirect_to users_path
	end
  private
  def set_follow_relationship
    @follow_relationship = FollowRelationship.find(params[:id])
  end
end