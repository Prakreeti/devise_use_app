class PublicController < ApplicationController
	#public page
	def public
    @posts = Post.includes(:user).paginate(page: params[:page], per_page: 20).
    															order("updated_at DESC")
   	respond_to do |format|
      format.html
      format.js
    end
  end
end