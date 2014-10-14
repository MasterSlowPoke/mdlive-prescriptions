class AddValidationToReminderRules < ActiveRecord::Migration
  def up
  	change_column :reminder_rules, :time_of_day, :string, null: false, default: "13:37"
  	change_column :reminder_rules, :day_of_week, :integer, null: false
  end

  def down
  	change_column :reminder_rules, :time_of_day, :string
  	change_column :reminder_rules, :day_of_week, :integer
  end
end
