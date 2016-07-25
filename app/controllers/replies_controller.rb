class RepliesController < ApplicationController
def create
	@comment = Comment.find(params[:comment_id])
	@post = Post.find(@comment.post_id)
	@reply = @comment.replies.new(reply_params)
	@reply.user_id = current_user.id
	@reply.post_id = @comment.post_id
	@reply.save
	redirect_to post_path(@post)
end
def destroy
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.find(params[:id])
    @reply.destroy
    redirect_to post_path(@post)
end
	 
private
	def reply_params
	params.require(:reply).permit(:content)
end

end