class AddTextableAndEmailableToReminderRules < ActiveRecord::Migration
  def change
    add_column :reminder_rules, :textable, :boolean, null: false, default: true
    add_column :reminder_rules, :emailable, :boolean, null: false, default: true
  end
end
