namespace :reminder do
	task email: :environment do 
		alert = Date.current + 5.minutes
		Reminder.all.each do |reminder|
			reminder.start_date
end