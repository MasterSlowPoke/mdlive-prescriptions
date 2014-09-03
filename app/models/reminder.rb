class Reminder < ActiveRecord::Base
	has_many :reminder_items
end
