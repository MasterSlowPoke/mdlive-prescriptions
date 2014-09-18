desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
	start_time = ScheduleLog.find_by(name: "email")
	end_time = Time.now + 10.minutes

  UserMailer.upcoming_reminder_email(start_time, end_time).deliver

  last_sent.time = end_time
  last_sent.save
end