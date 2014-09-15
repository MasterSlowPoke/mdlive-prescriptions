class Reminder < ActiveRecord::Base
	has_many :reminder_items

	def set_first_dose(date, time)
		self.start = DateTime.strptime(date + " | " + time, "%Y-%m-%d | %H:%M")
	end

	def reminder_items_setup?
		reminder_items.count >= num_per
	end

	def enumerate_doses(start_date = start, end_date = nil)
		return nil unless reminder_items_setup?

		all_doses = []

		reminder_items.each do |ri|
			ri.schedule.all_occurrences.each do |o|
				all_doses.push o if (o > start_date) && (end_date ? (o < end_date) : true)
			end
		end

		all_doses.sort
	end


	# def create_reminder_items
	# 	doses.times do |n|
	# 		ri = ReminderItem.new
			
	# 		case time_period.downcase
	# 		when "day"
	# 			ri.scheduled_time = (n.to_f/num_per).days.from_now
	# 		when "week"
	# 			ri.scheduled_time = (n.to_f/num_per).weeks.from_now
	# 		when "year"
	# 			ri.scheduled_time = (n.to_f/num_per*365).days.from_now
	# 		else
	# 			return false
	# 		end

	# 		ri.reminder = self
	# 		ri.save
	# 	end
	# end
end
