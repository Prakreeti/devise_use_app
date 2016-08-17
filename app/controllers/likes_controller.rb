class LikesController < ApplicationController

	#to like a post
	def create
		post = Post.find(params[:post_id])
		@like = current_user.likes.new(post: post)
		if @like.save
			redirect_to :back
		end
	end

	#to unlike a post
	def destroy
		@like = Like.find(params[:id])
		@like.destroy
		redirect_to :back
	end
end