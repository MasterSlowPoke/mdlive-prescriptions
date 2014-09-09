class ReminderItem < ActiveRecord::Base
	include IceCube

  belongs_to :reminder

  def set_yaml
  	schedule = Schedule.new(Time.now)
  	schedule.add_recurrence_rule Rule.daily.count(reminder.doses/reminder.num_per).hour_of_day(time_of_day.hour).minute_of_hour(time_of_day.min).second_of_minute(0)
  	self.yaml = schedule.to_yaml
  end
end
