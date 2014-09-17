class ChangeTimeOfDayToStringInReminderRules < ActiveRecord::Migration
  def up
  	change_column :reminder_rules, :time_of_day, :string
  end

  def down
  	change_column :reminder_rules, :time_of_day, :time
  end

end
