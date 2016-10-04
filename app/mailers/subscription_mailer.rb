class SubscriptionMailer < ApplicationMailer
	def send_email(email,post)    
	  @post = post
	  @subscriber = Subscriber.find_by(email: email)
	  mail to: email, subject: @post.title
	end
end
