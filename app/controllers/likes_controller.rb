class LikesController < ApplicationController
	def create
		post = Post.find(params[:post_id])
		@like = current_user.likes.new(post: post)
		if @like.save
			redirect_to post_path(post)
		end
	end
	def destroy
		@like = Like.find(params[:id])
		@like.destroy
		redirect_to posts_path
	end
end