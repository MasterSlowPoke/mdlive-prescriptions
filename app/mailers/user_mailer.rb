class UserMailer < ActionMailer::Base
  default from: "no-reply@blooming-harbor-4156.herokuapp.com"


	def welcome_email(user)
		@user = user

	  mail(to: user.email, subject: 'Welcome!')
	end


	def reminder_email(user, reminder)
		 mail(
      :subject => 'Did you know Postmark has a Heroku add-on?',
      :to      => user.email,
      :from    => 'craigsniffen@craigsniffen.com',
      :tag     => 'my-tag'
    )
	end
end