json.array!(@reminder_rules) do |reminder_rule|
  json.extract! reminder_rule, :id, :taken, :missed, :reminder_id_id, :scheduled_time
  json.url reminder_rule_url(reminder_rule, format: :json)
end
