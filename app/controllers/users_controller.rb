class UsersController < ApplicationController
	before_action :set_user, only: [:show, :follows, :followers]
	def index
		@users = User.paginate(page: params[:page])
	end
	def edit
		@user = User.find(current_user)
	end
	def update
		@user = User.find(current_user)
		if @user.update_with_password(user_params)
			redirect_to new_user_session_path
		else
			render "edit"
		end	
	end
	def show
	end
	def follows
    @users = @user.follows
  end

  def followers
    @users = @user.followers
  end

  def dashboard
  	if !user_signed_in?
  		redirect_to new_user_session_path
  	else
  		@user = User.find(current_user)
  		@posts = @user.feed
  	end
  end

	private

	def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation, :avatar)
  end

  def set_user
  	@user = User.find(params[:id])
  end
end
