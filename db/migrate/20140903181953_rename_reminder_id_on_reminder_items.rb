class RenameReminderIdOnReminderItems < ActiveRecord::Migration
  def change
  	rename_column :reminder_items, :reminder_id_id, :reminder_id
  end
end
