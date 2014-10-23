class ReminderRule < ActiveRecord::Base
	include IceCube

	serialize :schedule, Schedule

  validates :emailable, :textable, inclusion: [true, false]
  validates :time_of_day, format: { with: /\A[0-2][0-9](:)[0-5][0-9]\z/, message: "is not a valid time." }
  validates :day_of_week, numericality: { only_integer: true, greater_than: -1, less_than: 8 }

  belongs_to :reminder

  end

  def hour
    time_of_day.split(':')[0].to_i
  end

  def min
    time_of_day.split(':')[1].to_i
  end

  def ical_freq
    day_of_week == 7 ? "DAILY" : "WEEKLY"
  end

  def make_schedule(count = nil, start_time = nil)
    start_time = reminder.start if reminder && start_time == nil
  	new_rule = Rule.daily.hour_of_day(hour).minute_of_hour(min).second_of_minute(0)
  	new_rule = new_rule.count(count) if count

  	if (0..6).include? day_of_week
  		new_rule.day(day_of_week)
  	end
    schedule = Schedule.new(start_time)
  	schedule.add_recurrence_rule(new_rule)
    schedule
  end

  def occurs_between?(start_date, end_date)
  	return true if end_date.nil? || start_date.nil?

  	return schedule.occurs_between?(start_date, end_date)
  end
end
