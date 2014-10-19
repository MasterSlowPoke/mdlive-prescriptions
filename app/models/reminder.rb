class Reminder < ActiveRecord::Base
  has_many :reminder_rules, dependent: :destroy
  accepts_nested_attributes_for :reminder_rules, allow_destroy: true

	belongs_to :user

	validates :title, presence: true
	validates :doses, numericality: { greater_than: 0 }

	after_create :send_new_reminder_email

	after_save :assign_counts

  def exportable? 
  	!reminder_rules.empty?
  end

	def initialize(reminder_params, current_user)
		super(reminder_params)
		self.user = current_user
	end

	def get_current_doses
		enumerate_doses(Time.zone.now - 30.minutes, Time.zone.now + 30.minutes)
	end

	def get_days_doses(date)
		enumerate_doses(date.beginning_of_day, date.end_of_day)
	end

	def first_dose
		get_dose(:first)
	end

	def next_dose
		get_dose(:next_occurrence) || "All done!"
	end

	def last_dose
		get_dose(:last)
	end

	def days
		days = { 0 => nil, 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil}

		reminder_rules.all.each do |rr|
			return "Everyday" if rr.day_of_week == 7

			days[rr.day_of_week.to_i] = Date::ABBR_DAYNAMES[rr.day_of_week.to_i]
		end

		days = days.select { |key,val| val != nil }

		days.length == 7 ? "Everyday" : days.values.join(", ")
	end

  def assign_counts(start_time = start)
    return true if reminder_rules.empty?

    rule_data = {}

    reminder_rules.each do |rr|
      rr.set_schedule(nil, start)

      if (rr.schedule.first)
	      rule_data[rr.id] = OpenStruct.new
	      rule_data[rr.id].rule = rr
	      rule_data[rr.id].occurences = 0
	      rule_data[rr.id].next = rr.schedule.first
	    end
    end

    doses.times do
    	# find the time and id of the first rule in rule data
      next_id = rule_data.keys.first
      next_time = rule_data[next_id].next

      # test each rule to see which is the earliest
      rule_data.each do |id, data|
      	if data.next < next_time
      		next_id = id
      		next_time = data.next
      	end
      end

      # increase the count of the next rule, then find the next time that rule occurs
      rule_data[next_id].occurences += 1
      rule_data[next_id].next = rule_data[next_id].rule.schedule.next_occurrence(next_time)
    end

    reminder_rules.each do |rr|
      rr.set_schedule(rule_data[rr.id].occurences)
      rr.save
    end
  end

	def enumerate_doses(start_date = start, end_date = nil)
		all_doses = []

		reminder_rules.each do |ri|
			next unless ri.schedule && ri.schedule.terminating? 
			
			ri.schedule.all_occurrences.each do |o|
				all_doses.push NotificationTime.new(o, ri) if (o > start_date) && (end_date ? (o < end_date) : true)
			end
		end

		all_doses.sort do |a, b|
			a.time <=> b.time
		end
	end

	protected
		def send_new_reminder_email
			UserMailer.reminder_email(user, self).deliver
		end

		def get_dose(function)
			return "No Rules are set yet!" if reminder_rules.empty?

			doses = []
			
			reminder_rules.each do |rr|
				next unless rr.schedule.terminating?
				dose = rr.schedule.send(function) 
				doses << dose unless dose.nil?
			end
			doses.sort[0]
		end
end 
