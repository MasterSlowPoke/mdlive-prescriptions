class Reminder < ActiveRecord::Base
	has_many :reminder_items

	after_create :send_new_reminder_email

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
		return nil unless reminder_items_setup?

		all_doses = []

		reminder_items.each do |ri|
			ri.schedule.all_occurrences.each do |o|
				all_doses.push o
			end
		end

		all_doses.sort
	end

protected
def send_new_reminder_email
	UserMailer.reminder_email(user, self).deliver
end
end 
