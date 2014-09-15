class AddUserIdToReminders < ActiveRecord::Migration
  def change
    add_reference :reminders, :user, index: true
  end
end
