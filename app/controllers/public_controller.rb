class PublicController < ApplicationController
	#public page
	def public
    @posts = Post.includes(:user).paginate(page: params[:page]).
    															order("updated_at DESC")
  end
end