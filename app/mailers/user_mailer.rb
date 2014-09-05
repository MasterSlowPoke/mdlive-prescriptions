class UserMailer < ActionMailer::Base
  default from: "samuelezobel@gmail.com"
end

def welcome_email(user)
    @user = user
    @url  = 'https://www.mdlive.com/consumer/choose.html'
    mail(to: @user.email, subject: 'You have a Reminder!')
  end
end
