class AddUnsubscribedViaTwiliotoUsers < ActiveRecord::Migration
  def change
    add_column :users, :unsubbed_via_twilio, :boolean, default: false, null: false
  end
end
