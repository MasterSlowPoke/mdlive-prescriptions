class RenameIcalScheduleOnReminderItems < ActiveRecord::Migration
  def change
  	rename_column :reminder_items, :ical_schedule, :yaml
  end
end
