desc "This task is called by the Heroku scheduler add-on"
task email: :environment do 
	alert = Date.current + 5.minutes
	Reminder.all.each do |reminder|
		reminder.start_date
	end
end