class ReminderItem < ActiveRecord::Base
	include IceCube

	serialize :schedule, Schedule

  belongs_to :reminder

  def initialize(review_item_params = {})
  	super(review_item_params)
  	set_schedule unless review_item_params.empty?
  end

  def update(review_item_params)
  	super(review_item_params)
  	set_schedule
  	self.save
  end

  def set_schedule
  	self.schedule = Schedule.new(Time.now)
  	self.schedule.add_recurrence_rule( 
  		Rule.daily.count(reminder.doses/reminder.num_per).hour_of_day(time_of_day.hour).minute_of_hour(time_of_day.min).second_of_minute(0))
  end

  def occurs_between?(start_date, end_date)
  	return true if end_date.nil? || start_date.nil?

  	return schedule.occurs_between?(start_date, end_date)
  end
end
