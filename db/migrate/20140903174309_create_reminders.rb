class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :title
      t.integer :num_per
      t.string :time_period
      t.text :notes
      t.timestamp :start
      t.integer :doses

      t.timestamps
    end
  end
end
