class ChangeDayOfWeekToIntegerOnReminderItems < ActiveRecord::Migration
  def up
    change_column :reminder_items, :day_of_week, 'integer USING CAST(day_of_week AS integer)'
  end

  def down
    change_column :reminder_items, :day_of_week, :string
  end
end
