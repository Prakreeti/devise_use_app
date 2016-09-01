#over-riding the registrations controller of devise
class RegistrationsController < Devise::RegistrationsController
	before_action :authenticate_user!
	
	def index
		@users = User.all 
	end
	
	protected

  def update_resource(resource, params)
   	resource.update_without_password(params)
  end

	private
	
	def sign_up_params
		params.require(:user).permit(:email, :username, :password,
									   :password_confirmation, :name, :city, :fb_profile, :avatar)
	end

	def account_update_params
		params.require(:user).permit(:username, :name,
			               :city, :avatar, :about)
	end
end
