class AddDayOfWeekandTimeOfDayToReminderItems < ActiveRecord::Migration
  def change
    add_column :reminder_items, :day_of_week, :string
    add_column :reminder_items, :time_of_day, :time
    remove_column :reminder_items, :taken
    remove_column :reminder_items, :missed
    remove_column :reminder_items, :scheduled_time
  end
end
