class RemoveNumPerFromReminder < ActiveRecord::Migration
  def change
    remove_column :reminders, :num_per, :integer
  end
end
