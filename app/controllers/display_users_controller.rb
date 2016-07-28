class DisplayUsersController < ApplicationController
	def index
		@users = User.all
	end
end
