json.array!(@reminders) do |reminder|
  json.extract! reminder, :id, :title, :num_per, :time_period, :notes, :start, :doses
  json.url reminder_url(reminder, format: :json)
end
