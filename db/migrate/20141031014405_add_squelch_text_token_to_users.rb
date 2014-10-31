class AddSquelchTextTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :squelch_text_token, :string
  end
end
