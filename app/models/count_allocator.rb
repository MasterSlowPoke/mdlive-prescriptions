class CountAllocator
  def initialize(reminder)
    @reminder = reminder
  end

  delegate :reminder_rules, :doses, :start, to: :@reminder

  def allocate!
    return true if reminder_rules.empty?

    rule_data = {}
    reminder_rules.each do |rr|
      rr.schedule = rr.make_schedule(nil, start)

      if (rr.schedule.first)
        rule_data[rr.id] = OpenStruct.new
        rule_data[rr.id].rule = rr
        rule_data[rr.id].occurences = 0
        rule_data[rr.id].next = rr.schedule.first
      end
    end

    doses.times do
      # find the time and id of the first rule in rule data
      next_id = rule_data.keys.first
      next_time = rule_data[next_id].next

      # test each rule to see which is the earliest
      rule_data.each do |id, data|
        if data.next < next_time
          next_id = id
          next_time = data.next
        end
      end

      # increase the count of the next rule, then find the next time that rule occurs
      rule_data[next_id].occurences += 1
      rule_data[next_id].next = rule_data[next_id].rule.schedule.next_occurrence(next_time)
    end

    reminder_rules.each do |rr|
      rr.update_column(:schedule, rr.make_schedule(rule_data[rr.id].occurences).to_yaml)
    end
  end
end