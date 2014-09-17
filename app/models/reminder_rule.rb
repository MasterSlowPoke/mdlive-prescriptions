class ReminderRule < ActiveRecord::Base
	include IceCube

	serialize :schedule, Schedule

  belongs_to :reminder

  def initialize(reminder_rule_params = {})
    super(reminder_rule_params)
    unless reminder_rule_params.empty?
      set_schedule
      self.save

      reminder.assign_counts
    end
  end

  def update(reminder_rule_params)
  	super(reminder_rule_params)
  	set_schedule
  	self.save

    reminder.assign_counts
  end

  def hour
    time_of_day.split(':')[0].to_i
  end

  def min
    time_of_day.split(':')[1].to_i
  end

  def set_schedule(count = nil)
  	self.schedule = Schedule.new(reminder.start)
  	new_rule = Rule.daily.hour_of_day(hour).minute_of_hour(min).second_of_minute(0)
  	new_rule = new_rule.count(count) if count

  	if (0..6).include? day_of_week
  		new_rule.day(day_of_week)
  	end

  	self.schedule.add_recurrence_rule(new_rule)
  end

  def occurs_between?(start_date, end_date)
  	return true if end_date.nil? || start_date.nil?

  	return schedule.occurs_between?(start_date, end_date)
  end
end
