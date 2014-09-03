class Reminder < ActiveRecord::Base
	has_many :reminder_items

	def create_reminder_items
		doses.times do |n|
			ri = ReminderItem.new
			ri.scheduled_time = DateTime.now + (1.day * n)
			ri.save
		end
	end
end
