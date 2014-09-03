class Reminder < ActiveRecord::Base
	has_many :reminder_items

	def create_reminder_items
		doses.times do |n|
			ri = ReminderItem.new
			
			case time_period.downcase
			when "day"
				ri.scheduled_time = (n.to_f/num_per).days.from_now
			when "week"
				ri.scheduled_time = (n.to_f/num_per).weeks.from_now
			when "year"
				ri.scheduled_time = (n.to_f/num_per*365).days.from_now
			else
				return false
			end

			ri.reminder = self
			ri.save
		end
	end
end
