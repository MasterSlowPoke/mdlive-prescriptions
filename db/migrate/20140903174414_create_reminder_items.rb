class CreateReminderItems < ActiveRecord::Migration
  def change
    create_table :reminder_items do |t|
      t.boolean :taken
      t.boolean :missed
      t.references :reminder_id, index: true
      t.timestamp :scheduled_time

      t.timestamps
    end
  end
end
