class ChangePhoneToBigIntOnUsers < ActiveRecord::Migration
  def change
  	change_column :users, :phone, 'bigint USING CAST("phone" AS bigint)'
  end
end
