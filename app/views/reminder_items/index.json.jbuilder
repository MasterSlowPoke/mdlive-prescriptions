json.array!(@reminder_items) do |reminder_item|
  json.extract! reminder_item, :id, :taken, :missed, :reminder_id_id, :scheduled_time
  json.url reminder_item_url(reminder_item, format: :json)
end
