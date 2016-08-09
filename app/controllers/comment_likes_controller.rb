class CommentLikesController < ApplicationController
	def create
		comment = Comment.find(params[:comment_id])
		@like = current_user.comment_likes.new(comment: comment)
		if @like.save
			redirect_to post_path(comment.post_id)
		end
	end
	def destroy
		@like = CommentLike.find(params[:id])
		@like.destroy
		redirect_to posts_path
	end
end