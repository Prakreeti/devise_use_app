class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id
		@comment.post_id = @post.id
		@comment.save
		if @comment.reply_to 
			@c = Comment.find(@comment.reply_to)
			@c.children_count += 1
			@c.save 
		end
		redirect_to post_path(@post)
	end
	def destroy
	    @post = Post.find(params[:post_id])
	    @comment = @post.comments.find(params[:id])
	    @comment.destroy
	    redirect_to post_path(@post)
	end
	def show
		@post = Post.find(params[:post_id])
	  @comment = @post.comments.find(params[:id])
	end
	private
		def comment_params
		params.require(:comment).permit(:content, :reply_to, :base_reply, :level)
	end
end