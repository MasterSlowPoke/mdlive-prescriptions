class RenameYamlToScheduleOnReminderItems < ActiveRecord::Migration
  def change
  	rename_column :reminder_items, :yaml, :schedule
  end
end
