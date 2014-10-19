class Reminder < ActiveRecord::Base
	has_many :reminder_rules

	belongs_to :user

	validates :title, presence: true
	validates :doses, numericality: { greater_than: 0 }

	after_create :send_new_reminder_email

  before_destroy :destroy_rules

  def exportable? 
  	!reminder_rules.empty?
  end

	def initialize(reminder_params, current_user)
		super(reminder_params)
		self.user = current_user
	end

	def update(reminder_params)
		super(reminder_params)
		assign_counts()
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

	def assign_counts
		return true if reminder_rules.empty?

		num_reminders = reminder_rules.count
		counts_hash = {}
		occurrences_hash = {}
		ri_hash = {}

		reminder_rules.each do |ri|
			counts_hash[ri.id] = 0
			occurrences_hash[ri.id] = ri.schedule.first
			ri_hash[ri.id] = ri
			ri.set_schedule
		end

		doses.times do
			next_occurrence = [occurrences_hash.keys.first, occurrences_hash[occurrences_hash.keys.first]]
			
			occurrences_hash.each do |id, time|
				next_occurrence = [id, time] if time && time < next_occurrence[1]
			end

			counts_hash[next_occurrence[0]] += 1
			occurrences_hash[next_occurrence[0]] = ri_hash[next_occurrence[0]].schedule.next_occurrence(next_occurrence[1])
		end

		reminder_rules.each do |ri|
			ri.set_schedule(counts_hash[ri.id])
			ri.save
		end
	end

	def enumerate_doses(start_date = start, end_date = nil)
		all_doses = []

		reminder_rules.each do |ri|
			next unless ri.schedule.terminating? 
			
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

		def destroy_rules
			reminder_rules.each do |rr|
				rr.destroy
			end
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
