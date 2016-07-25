class RegistrationsController < Devise::RegistrationsController
	def index
		@users = User.all? 
	end
	private
	def sign_up_params
		params.require(:user).permit(:email, :username, :password, :password_confirmation, :name, :city, :fb_profile)
	end

	def account_update_params
		params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password, :name, :city)
	end
end
