class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reminders

  def send_reminders(start_time, end_time)
  	reminder_list = {}

  	reminders.each do |r|
  		r.enumerate_doses(start_time, end_time).each do |dose|
  			reminder_list[dose] = r
  		end
  	end

  	reminder_list['test'] = Reminder.first

  	unless reminder_list.empty?
  		UserMailer.upcoming_reminder_email(self, start_time, end_time, reminder_list).deliver
  	end
	end
end
