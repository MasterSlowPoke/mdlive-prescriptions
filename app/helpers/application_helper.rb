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
		if time.respond_to? :strftime 
    	time.in_time_zone.strftime("%A, %b #{time.day.ordinalize} %Y, @ %l:%M %p") 
    else
    	time
    end
  end

  def nav_link(link_text, link_path)
	  class_name = current_page?(link_path) ? 'current' : nil

	  content_tag(:li) do
	    link_to link_text, link_path, class: class_name
	  end
	end
end
