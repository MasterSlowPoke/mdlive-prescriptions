desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
	curr_time = Time.now

  UserMailer.upcoming_reminder_email(Time.parse(ENV['LAST_SENT'])).deliver
  
  ENV['LAST_SENT'] = curr_time + 10.minutes
end