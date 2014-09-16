class DeleteHomes < ActiveRecord::Migration
  def change
  	drop_table :homes
  end
end
