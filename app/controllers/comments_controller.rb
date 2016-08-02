class CommentsController < ApplicationController
	before_action :setpost, only:[:create, :destroy, :show]
	def create
		@comment = Comment.create(comment_params.merge({post_id: @post.id, user_id: current_user.id}))
		if @comment.reply_to 
			@c = Comment.find(@comment.reply_to)
			@c.children_count += 1
			@c.save 
		end
		redirect_to post_path(@post)
	end
	def destroy
	    @comment = @post.comments.find(params[:id])
	    @comment.destroy
	    redirect_to post_path(@post)
	end
	def show
	  @comment = @post.comments.find(params[:id])
	end
	private
	def comment_params
		params.require(:comment).permit(:content, :reply_to, :base_reply, :level)
	end
	def setpost
		@post = Post.find(params[:post_id])
	end
end
