class UserMailer < ActionMailer::Base
  default from: 'craigsniffen@craigsniffen.com'
	helper ApplicationHelper

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

	def upcoming_reminder_email(user, start_time, end_time, reminder_list)
		@last_sent = start_time
		@reminder_list = reminder_list

		mail(
      subject: 'You have an upcoming reminder!',
      to: user.email,
    )
	end
end