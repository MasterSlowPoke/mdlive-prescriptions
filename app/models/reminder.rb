class Reminder < ActiveRecord::Base
	has_many :reminder_items

	def set_first_dose(date, time)
		self.start = DateTime.strptime(date + " | " + time, "%Y-%m-%d | %H:%M")
	end

	def reminder_items_setup?
		reminder_items.count >= num_per
	end

	def get_days_doses(day)
		if start_date > day
			return []
		end

		doses = []
		reminder_items.each do |ri|
			if start_date == day
				if ri.time_of_day.hour < start.hour
					next
				elsif ri.time_of_day.hour == start.hour
					if ri.time_of_day.min < start.min
						next
					end
				end
			end
					 	 
			doses << ri
		end

		doses
	end


	def start_date
		Date.new(start.year, start.month, start.day)
	end

	def end_date
	end

	def first_dose
		first_dose = nil
		n = 0

		until first_dose
			first_dose = get_days_doses(start_date + n.days).first
			n +=1
		end

		first_dose
	end

	def last_dose
	end

	def enumerate_doses
		doses_array = [first_dose]

		(doses - 1).times do
		end

		doses_array
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
