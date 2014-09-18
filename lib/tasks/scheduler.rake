desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  UserMailer.upcoming_reminder_email.deliver
end