class AddValidationToReminders < ActiveRecord::Migration
  def up
    change_column :reminders, :title, :string, null: false
    change_column :reminders, :doses, :integer, null: false
    change_column :reminders, :start, :datetime, null: false
  end

  def down
  	change_column :reminders, :title, :string
    change_column :reminders, :doses, :integer
    change_column :reminders, :start, :datetime
  end
end
