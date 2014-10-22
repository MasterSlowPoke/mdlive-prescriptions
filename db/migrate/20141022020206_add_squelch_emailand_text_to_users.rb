class AddSquelchEmailandTextToUsers < ActiveRecord::Migration
  def change
    add_column :users, :squelch_email, :boolean, default: false, null: false
    add_column :users, :squelch_text, :boolean, default: false, null: false
  end
end
