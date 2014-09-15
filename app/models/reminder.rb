class Reminder < ActiveRecord::Base
	has_many :reminder_items

	def set_first_dose(date, time)
		self.start = DateTime.strptime(date + " | " + time, "%Y-%m-%d | %H:%M")
	end

	def reminder_items_setup?
		reminder_items.count >= num_per
	end

	def assign_counts
		num_reminders = reminder_items.count
		counts_hash = {}
		occurrences_hash = {}
		ri_hash = {}
		
		reminder_items.each do |ri|
			counts_hash[ri.id] = 0
			occurrences_hash[ri.id] = ri.schedule.next_occurrence
			ri_hash[ri.id] = ri
			ri.set_schedule
		end

		doses.times do
			next_occurrence = [occurrences_hash.keys.first, occurrences_hash[occurrences_hash.keys.first]]
			
			occurrences_hash.each do |id, time|
				next_occurrence = [id, time] if time && time < next_occurrence[1]
			end

			counts_hash[next_occurrence[0]] += 1
			occurrences_hash[next_occurrence[0]] = ri_hash[next_occurrence[0]].schedule.next_occurrence(next_occurrence[1])
		end

		puts counts_hash
		puts occurrences_hash

		reminder_items.each do |ri|
			ri.set_schedule(counts_hash[ri.id])
			ri.save
		end
	end

	def enumerate_doses(start_date = start, end_date = nil)
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
