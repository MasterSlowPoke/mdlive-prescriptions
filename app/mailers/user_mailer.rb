class UserMailer < ActionMailer::Base
  default from: "ortiz_frank@hotmail.com"


	def welcome_email(user)
		@user = user
	    # @url  = 'https://www.mdlive.com/consumer/choose.html'
	    mail(to: user.email, subject: 'You have a Reminder!')
	end


	def reminder_email(user)
		@user = user
		mail(to: user.email, subject: 'You have a real Reminder!')
	end

# attachments['filename.jpg'] = File.read('/path/to/filename.jpg')

# encoded_content = SpecialEncode(File.read('/path/to/filename.jpg'))
# attachments['filename.jpg'] = {mime_type: 'application/x-gzip',
# 	encoding: 'SpecialEncoding',
# 	content: encoded_content }

	# def welcome
	# 	attachments.inline['image.jpg'] = File.read('/path/to/image.jpg')
	# end

end