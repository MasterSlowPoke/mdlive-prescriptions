class Reminder < ActiveRecord::Base
	has_many :reminder_items

	def create_reminder_items
		doses.times do |n|
			ri = ReminderItem.new
			ri.scheduled_time = n.days.from_now
			ri.save
		end
	end
end
