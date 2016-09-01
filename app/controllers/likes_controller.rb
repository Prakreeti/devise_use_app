class LikesController < ApplicationController
	before_action :authenticate_user!

	#to like a post
	def create
		@post = Post.find_by(:id => params[:post_id])
		@like = current_user.likes.new(post: @post)
		if @like.save
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		end
	end

	#to unlike a post
	def destroy
		@like = Like.find_by(:id => params[:id])
		@post = Post.find_by(:id => @like.post_id)
		@like.destroy
		respond_to do |format|
				format.html {redirect_to :back}
				format.js
		end
	end
end