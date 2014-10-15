class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :phone, numericality: { greater_than: 999999999, message: "Number must be a 7 digit number with area code." }

  has_many :reminders, dependent: :destroy

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
  		r.enumerate_doses(start_time, end_time).each do |nt|
  			reminder_list[nt.time] = nt.reminder_rule
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

    reminder_list.each do |time, reminder_rule|
      message += "\n#{reminder_rule.reminder.title} @ #{time.strftime("%l:%M %p")}" if reminder_rule.textable
    end

    return if message == "Prescription Reminder:" # don't send empty messages

    TwilioClient.account.messages.create({
      :from => '+17272286083', 
      :to => phone, 
      :body => message,
    })
  end 

  def get_current_doses 
    all_doses = {}

    reminders.each do |r|
      r.get_current_doses.each do |nt|
        time = nt.time.strftime("%l:%M %p")
        all_doses[time] ||= [] 
        all_doses[time] << r
      end
    end

    all_doses.sort do |a, b|
      if a[0][-2] == "A" && b[0][-2] == "P" 
        -1
      elsif a[0][-2] == "P" && b[0][-2] == "A"
        1
      else
        a[0] <=> b[0]
      end
    end
  end

  def get_days_doses(date)
    all_doses = {}

    reminders.each do |r|
      r.get_days_doses(date).each do |nt|
        time = nt.time.strftime("%l:%M %p")
        all_doses[time] ||= [] 
        all_doses[time] << r
      end
    end

    all_doses.sort do |a, b|
      if a[0][-2] == "A" && b[0][-2] == "P" 
        -1
      elsif a[0][-2] == "P" && b[0][-2] == "A"
        1
      else
        a[0] <=> b[0]
      end
    end
  end
end
