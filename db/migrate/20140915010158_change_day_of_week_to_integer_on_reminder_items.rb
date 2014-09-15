class ChangeDayOfWeekToIntegerOnReminderItems < ActiveRecord::Migration
  def up
  	ReminderItem.all.each do |ri|
  		if ri.day_of_week and !ri.day_of_week.is_a?(Integer)
	  		ri.day_of_week = case ri.day_of_week.downcase.slice(0,2)
	  											when "su"
	  												0
	  											when "mo"
	  												1
	  											when "tu"
	  												2
	  											when "we"
	  												3
	  											when "th"
	  												4
	  											when "fr"
	  												5
	  											when "sa"
	  												6
	  											else
	  												7
	  											end
	  		ri.save
	  	end
  	end

    change_column :reminder_items, :day_of_week, :integer
  end

  def down
    change_column :reminder_items, :day_of_week, :string
  end
end
