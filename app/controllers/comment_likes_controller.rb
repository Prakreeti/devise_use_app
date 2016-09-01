class CommentLikesController < ApplicationController
	before_action :authenticate_user!

	#creates a new like
	def create
		@comment = Comment.find_by(:id => params[:comment_id])
		@like = current_user.comment_likes.new(comment: @comment)
		if @like.save
			respond_to do |format|
				format.js
			end
		end
	end
	
	#destroys the like
	def destroy
		@like = CommentLike.find_by(:id => params[:id])
		@comment =  Comment.find(@like.comment_id)
		@like.destroy
		respond_to do |format|
				format.js
		end
	end
end
