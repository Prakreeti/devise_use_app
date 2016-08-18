class CommentsController < ApplicationController
	before_action :setpost, only:[:create, :destroy, :show]

	#creates the comment
	def create
		@comment = Comment.create(comment_params.merge({post_id: @post.id,
																		 user_id: current_user.id}))
		if @comment.reply_to 
			@c = Comment.find(@comment.reply_to)
			@c.children_count += 1
			@c.save 
		end
		redirect_to :back
	end

	#destroys the comment
	def destroy
	  @comment = @post.comments.find(params[:id])
	  @comment.destroy
	  redirect_to :back
	end
	
	#for displaying the comments of a post
	def show
	  @comment = @post.comments.find(params[:id])
	end

	#to display the list of users who liked the comment
	def liked_by
		@comment = Comment.find(params[:id])
		@users = @comment.liked_by
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :reply_to,
																		 :base_reply, :level)
	end
	def setpost
		@post = Post.includes(:comments).find(params[:post_id])
	end
end
