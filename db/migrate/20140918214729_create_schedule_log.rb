class CreateScheduleLog < ActiveRecord::Migration
  def change
    create_table :schedule_logs do |t|
      t.datetime :last_ran
      t.string :name
    end
    add_index :schedule_logs, :name
  end
end
