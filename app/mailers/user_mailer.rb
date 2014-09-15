class UserMailer < ActionMailer::Base
  default from: "ortiz_frank@hotmail.com"


	def welcome_email(user)
		@user = user

	    # @url  = 'https://www.mdlive.com/consumer/choose.html'
	    mail(to: user.email, subject: 'Welcome!')
	end


	def reminder_email(user, reminder)
		@user = user
		@reminder = reminder
		mail(to: user.email, subject: 'You have a Reminder!')
	end

end