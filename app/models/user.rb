class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :phone, numericality: { greater_than: 999999999, message: "Number must be a 7 digit number with area code." }

  has_many :reminders

  def phone=(n)
    n.gsub!(/\D/, '') if n.is_a?(String)
    super(n)
  end

  def formatted_phone
    if phone.to_s.length > 9
      ActionController::Base.helpers.number_to_phone phone, area_code: true
    else
      phone
    end
  end

  def send_reminders(start_time, end_time)
  	reminder_list = {}

  	reminders.each do |r|
  		r.enumerate_doses(start_time, end_time).each do |time|
  			reminder_list[time] = r
  		end
  	end

  	unless reminder_list.empty?
      reminder_list = reminder_list.sort
  		UserMailer.upcoming_reminder_email(self, start_time, end_time, reminder_list).deliver
      send_texts(reminder_list)
  	end
	end

  def send_texts(reminder_list)
    return unless phone

    message = "Prescription Reminder:"

    reminder_list.each do |time, reminder|
      message += "\n#{reminder.title} @ #{time.strftime("%l:%M %p")}"
    end

    return if message == "Prescription Reminder:" # don't send empty messages

    TwilioClient.account.messages.create({
      :from => '+17272286083', 
      :to => phone, 
      :body => message,
    })
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
