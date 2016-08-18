class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  #to display all posts with pagination
  def index
    if params[:search]
      @posts = Post.search(params[:search]).paginate(page: params[:page]).order("created_at DESC")
    else
      @posts = Post.paginate(page: params[:page]).order("created_at DESC")
    end
  end

  #to show the content of each post including its comments and ratings
  def show
  end

  def new
    @post = Post.new
  end

  #to edit a post
  def edit
  end

  #to create a new post
  def create
    @post = current_user.posts.new(post_params)
    @post.posted_by = current_user.name
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  #to update a post
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  #to destroy a post
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #to show all posts of current user
  def myblogs
    if params[:search]
      @posts = current_user.posts.search(params[:search]).paginate(page: params[:page]).order("created_at DESC")
    else
      @posts = current_user.posts.paginate(page: params[:page]).order("created_at DESC")
    end
  end

  #to show posts with a certain tag
  def tagged
    if params[:tag].present? 
      @posts = Post.tagged_with(params[:tag])
    else 
      @posts = Post.all
    end  
  end

  def liked_by
    post = Post.find(params[:id])
    @users = post.liked_by
  end

  private
    def set_post
      @post = Post.includes(:comments).find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :image, :tag_list)
    end
end
