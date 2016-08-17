class SubscribersController < ApplicationController
	
	#to add a new email which subscribes to the website
	def create
    @subscriber = Subscriber.new(subscriber_params)
    @subscriber.save
    redirect_to :back
  end

  private
  def subscriber_params
  	params.require(:subscriber).permit(:email)
  end
end
