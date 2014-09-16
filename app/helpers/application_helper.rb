module ApplicationHelper
	def int_to_day_of_week(dow)
		dow = dow.to_i

		if (0..6).include? dow
			Date::DAYNAMES[dow]
		else
			"Everyday"
		end
	end

	def formatted_time(time)
    time.strftime("%A, %b #{time.day.ordinalize} %Y, @ %l:%M %p") if time.respond_to? :strftime
  end
end
