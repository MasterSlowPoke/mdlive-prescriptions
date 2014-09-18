class UserMailer < ActionMailer::Base
  default from: "no-reply@blooming-harbor-4156.herokuapp.com"


	def welcome_email(user)
		@user = user

	  mail(to: user.email, subject: 'Welcome!')
	end


	def reminder_email(user, reminder)
		@user = user
		@reminder = reminder
		mail(to: user.email, subject: 'You have a Reminder!')
	end
end