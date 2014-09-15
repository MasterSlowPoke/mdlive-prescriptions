module ApplicationHelper
	def int_to_day_of_week(dow)
		dow = dow.to_i

		if (0..6).include? dow
			Date::DAYNAMES[dow]
		else
			"Everyday"
		end
	end
end
