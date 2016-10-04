class UsersController < ApplicationController
	before_action :set_user, only: [:show, :follows, :followers]
	$nearby_friends = nil

	#to show all users using pagination
	def index
    if params[:search]
      @users = User.search(params[:search])
              .paginate(page: params[:page])
              .order("updated_at DESC")
    else
      @users = User.paginate(page: params[:page])
              .order("updated_at DESC")
    end
    user_collection
	end

	#to edit the password of current user
	def edit
		@user = User.find_by(id: current_user)
	end

	#to update the password of current user
	def update
		@user = User.find_by(id: current_user)
		if @user.update_with_password(user_params)
      flash[:notice] = "Password successfully updated."
			redirect_to new_user_session_path
		else
			render 'edit'
		end	
	end

	#to show the profile of the users
	def show
    about_user
	end

	#to list the people current user follows
	def follows
    @users = @user.follows
  end

  #to list the followers of the current user
  def followers
    @users = @user.followers
  end

  #to display the feed 
	def dashboard
  	if !user_signed_in?
  		redirect_to new_user_session_path
  	else
  		@user = current_user
  		@posts = @user.feed
  	end
  end

  #to find friends nearby based on current location of the user
  def find_friends
	 	$nearby_friends = current_user.friends.near(params[:current_location], 50)
	 	redirect_to :home
  end

	private

	def user_params
    params.require(:user).permit(:current_password,
     :password, :password_confirmation, :avatar, :latitude, :longitude)
  end

  def set_user
  	@user = User.includes(:posts).find_by(id: params[:id])
    if @user == nil
      redirect_to :users,
         :flash => { :notice => "You tried to access a non-existing user." }
    end
  end

  def user_collection
    @users_collection = []
    @all_users = @users
    @all_users.each do |user|
      each_user = { name: user.name, city: user.city, fb_profile: user.fb_profile,
          user: user, avatar: user.avatar,
          is_friend: current_user.has_friend?(user),
          has_got_friend_request: current_user.has_sent_friend_request_to?(user),
          has_sent_friend_request: user.has_sent_friend_request_to?(current_user),
          friendship: current_user.friendship(user),
          friend_request_sent: current_user.friend_request(user),
          is_followed: current_user.is_following?(user),
          follow_relation: current_user.follow_relation(user)  }
      @users_collection << each_user
    end
  end

  def about_user
    @about_user = {name: @user.name, city: @user.city,
        about: @user.about, avatar: @user.avatar, 
        followers_count: @user.is_followed_by,
        following_count: @user.is_following,
        is_friend: current_user.has_friend?(@user),
        has_got_friend_request: current_user.has_sent_friend_request_to?(@user),
        has_sent_friend_request: @user.has_sent_friend_request_to?(current_user),
        friendship: current_user.friendship(@user),
        friend_request_sent: current_user.friend_request(@user),
        is_followed: current_user.is_following?(@user),
        follow_relation: current_user.follow_relation(@user),
        posts: @user.posts,
        user: @user }
  end
end
