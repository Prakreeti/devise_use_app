class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only:[:new, :create, :destroy, :show, :update, :edit]

	#creates the comment
	def new
		@comment = Comment.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@comment = Comment.new(comment_params.merge({post_id: @post.id,
																		 user_id: current_user.id}))
		if @comment.save
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
	end

	def edit
		@comment = @post.comments.find_by(id: params[:id])
		respond_to do |format|
			format.js
		end
	end

	def update
		@comment = @post.comments.find_by(id: params[:id])
  	if @comment.update(comment_params)
  		respond_to do |format|
  			format.js
  		end
  	end
	end

	#destroys the comment
	def destroy
	  @comment = @post.comments.find_by(id: params[:id])
	  @comment_ids = [@comment.id]
		if(@comment.children)
			find_all_child_comment(@comment.children)
		end
    @comment.destroy
    respond_to do |format|
    	format.html {redirect_to post_path(@post)}
    	format.js
    end
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

	def find_all_child_comment comments
		comments.each do |comment|
			@comment_ids.push(comment.id)
			if(comment.children)
				find_all_child_comment(comment.children)
			end
		end
	end
end
