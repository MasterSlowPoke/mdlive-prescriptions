class UserMailer < ActionMailer::Base
  default from: "ortiz_frank@hotmail.com"


	def welcome_email(user)
		@user = user
		Rails.logger.info "sending welcome email to #{user.email}"
	    # @url  = 'https://www.mdlive.com/consumer/choose.html'
	    mail(to: user.email, subject: 'Welcome!')
	end


	def reminder_email(user)
		@user = user
		mail(to: user.email, subject: 'You have a Reminder!')
	end

end