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

  	unless reminder_list.empty?
  		UserMailer.upcoming_reminder_email(self, start_time, end_time, reminder_list).deliver
  	end
	end

  def get_days_doses(date)
    all_doses = {}

    reminders.each do |r|
      r.get_days_doses(date).each do |dose|
        time = dose.strftime("%l:%M %p")
        all_doses[time] ||= [] 
        all_doses[time] << r
      end
    end

    all_doses
  end
end
