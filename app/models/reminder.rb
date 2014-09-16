class Reminder < ActiveRecord::Base
	has_many :reminder_rules

	belongs_to :user

	after_create :send_new_reminder_email

	def initialize(reminder_params, current_user)
		super(reminder_params)
		self.user = current_user
	end

	def get_days_doses(date)
		enumerate_doses(date.beginning_of_day, date.end_of_day)
	end

	def set_start(date, time)
		self.start = DateTime.strptime(date + " | " + time, "%Y-%m-%d | %H:%M")
	end

	def first_dose
		return "No Rules are set yet!" if reminder_rules.empty?
		
		doses = []
		
		reminder_rules.each do |rr|
			doses << rr.schedule.first
		end

		doses.sort[0]
	end

	def assign_counts
		return if reminder_rules.empty?

		num_reminders = reminder_rules.count
		counts_hash = {}
		occurrences_hash = {}
		ri_hash = {}
		
		reminder_rules.each do |ri|
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

		reminder_rules.each do |ri|
			ri.set_schedule(counts_hash[ri.id])
			ri.save
		end
	end

	def enumerate_doses(start_date = start, end_date = nil)
		all_doses = []

		reminder_rules.each do |ri|
			ri.schedule.all_occurrences.each do |o|
				all_doses.push o if (o > start_date) && (end_date ? (o < end_date) : true)
			end
		end

		all_doses.sort
	end


protected
def send_new_reminder_email
	UserMailer.reminder_email(user, self).deliver

end


	# def create_reminder_rules
	# 	doses.times do |n|
	# 		ri = ReminderRule.new
			
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
