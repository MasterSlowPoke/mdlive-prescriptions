class AddICalScheduleToReminderItems < ActiveRecord::Migration
  def change
    add_column :reminder_items, :ical_schedule, :text
  end
end
