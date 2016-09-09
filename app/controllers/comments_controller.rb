class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only:[:create, :destroy, :show]

	#creates the comment
	def create
		@comment = Comment.new(comment_params.merge({post_id: @post.id,
																		 user_id: current_user.id}))
		@comment.save
		redirect_to :back
	end

	#destroys the comment
	def destroy
	  @comment = @post.comments.find_by(id: params[:id])
	  @comment.destroy
	  redirect_to :back
	end
	
	#for displaying the comments of a post
	def show
	  @comment = @post.comments.find_by(id: params[:id])
	end

	#to display the list of users who liked the comment
	def liked_by
		comment = Comment.includes(:liked_by).find_by(id: params[:id])
		@users = comment.has_been_liked_by									
	end

	private
	
	def comment_params
		params.require(:comment).permit(:content, :reply_to,
																		 :base_reply, :level)
	end
	
	def set_post
		@post = Post.includes(:comments).find_by(id: params[:post_id])
	end
end
