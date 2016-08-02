class UsersController < ApplicationController
	def index
		@users = User.paginate(page: params[:page])
	end
	def edit
		@user = User.find(current_user)
	end
	def update
		@user = User.find(current_user.id)
		if @user.update_with_password(user_params)
				redirect_to  new_user_session_path
		else
				render "edit"
		end	
	end
	def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
