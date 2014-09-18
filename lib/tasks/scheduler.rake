desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
	sl = ScheduleLog.find_by(name: "email")
	start_time = sl.last_ran
	end_time = Time.now + 10.minutes

  UserMailer.upcoming_reminder_email(start_time, end_time).deliver

  sl.last_ran = end_time
  sl.save
end