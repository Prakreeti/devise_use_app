class CommentLikesController < ApplicationController
	#creates a new like
	def create
		comment = Comment.find(params[:comment_id])
		@like = current_user.comment_likes.new(comment: comment)
		if @like.save
			redirect_to :back
		end
	end
	
	#destroys the like
	def destroy
		@like = CommentLike.find(params[:id])
		@like.destroy
		redirect_to :back
	end
end