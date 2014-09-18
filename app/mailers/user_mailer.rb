class UserMailer < ActionMailer::Base
  default from: 'craigsniffen@craigsniffen.com'


	def welcome_email(user)
		@user = user

		mail(
      :subject => 'Welcome to the MDLive Prescription App!',
      :to      => user.email,
    )
	end

	def reminder_email(user, reminder)
		mail(
      :subject => 'You\'ve created a new Reminder!',
      :to      => user.email,
    )
	end

	def upcoming_reminder_email(start_time, end_time)
		@last_sent = start_time

		mail(
      :subject => 'Heroku Scheduler works!',
      :to      => 'craigsniffen@craigsniffen.com',
    )
	end
end