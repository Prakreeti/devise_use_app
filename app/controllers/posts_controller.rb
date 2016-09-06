class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update]

  #to display all posts with pagination
  def index
    if params[:search]
      @posts = Post.search(params[:search])
              .paginate(page: params[:page])
              .includes(:user).order("updated_at DESC")
    else
      @posts = Post.paginate(page: params[:page])
              .includes(:user).order("updated_at DESC")
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
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to @post 
    else
      flash[:notice] = 'Post could not be created. Try again.'
      render :new
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
      @posts = current_user.posts.search(params[:search]).
               paginate(page: params[:page]).order("updated_at DESC")
    else
      @posts = current_user.posts.paginate(page: params[:page]).
               order("updated_at DESC")
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

  #to find the users who have liked the post
  def liked_by
    post = Post.find_by(:id => params[:id])
    @users = post.liked_by
  end

  private
  
    def set_post
      @post = Post.includes(:user, :tags).find_by(:id => params[:id])
      if @post.blank?
        redirect_to :posts,
         :flash => { :notice => "You tried to access a non-existing post." }
      end
    end

    def post_params
      params.require(:post).permit(:title, :content, :image, :tag_list)
    end

    def check_user
      if @post.user_id != current_user.id
        redirect_to :posts,
         :flash => { :notice => "You cannot change other's posts." }
      end
    end
end
