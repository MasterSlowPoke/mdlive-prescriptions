class RenameReminderItemsToReminderRules < ActiveRecord::Migration
  def change
  	rename_table :reminder_items, :reminder_rules
  end
end
