class SubscribersController < ApplicationController
	#to add a new email which subscribes to the website
	def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      flash[:notice] = "You have been subscribed"
      redirect_to :back
    end
  end

  def unsubscribe
  end

  def destroy
    @subscriber = Subscriber.find_by(email: params[:subscriber][:email])
    if @subscriber.destroy
      flash[:notice] = "You have been unsubscribed"
      redirect_to root_path
    end
  end


  private

  def subscriber_params
  	params.require(:subscriber).permit(:email)
  end
end
