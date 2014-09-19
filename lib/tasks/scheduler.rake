desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
	sl = ScheduleLog.find_by(name: "email")
	start_time = sl.last_ran
	end_time = Time.now + 20.minutes

  User.all.each do |u|
  	u.send_reminders(start_time, end_time)
  end

  sl.last_ran = end_time
  sl.save
end