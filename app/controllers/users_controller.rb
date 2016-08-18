class UsersController < ApplicationController
	before_action :set_user, only: [:show, :follows, :followers]
	$nearby_friends = nil

	#to show all users using pagination
	def index
		@users = User.paginate(page: params[:page])
	end

	#to edit the datils of current user
	def edit
		@user = User.find(current_user)
	end

	#to update the details of current user
	def update
		@user = User.find(current_user)
		if @user.update_with_password(user_params)
			redirect_to new_user_session_path
		else
			render "edit"
		end	
	end

	#to show the profile of the users
	def show
	end

	#to list the people current user follows
	def follows
    @users = @user.follows
  end

  #to list the followers of the current user
  def followers
    @users = @user.followers
  end

  #to display the feed 
	def dashboard
  	if !user_signed_in?
  		redirect_to new_user_session_path
  	else
  		@user = User.find(current_user)
  		@posts = @user.feed
  	end
  end

  #to find friends nearby based on current location of the user
  def find_friends
	 	$nearby_friends = current_user.friends.near(params[:current_location], 50)
	 	redirect_to :back
  end
  	
	private

	def user_params
    params.require(:user).permit(:current_password,
     :password, :password_confirmation, :avatar, :latitude, :longitude)
  end
  def set_user
  	@user = User.includes(:posts).find(params[:id])
  end
end
