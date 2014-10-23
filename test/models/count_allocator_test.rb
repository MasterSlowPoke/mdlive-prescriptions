require 'test_helper.rb'

class CountAllocatorTest < ActiveSupport::TestCase
  setup do
    @reminder = reminders(:three_rules)
    @allocator = CountAllocator.new(@reminder)
    refute_nil @reminder, "reminder fixture 'three_rules' is malformed"
    refute_nil @allocator, 'allocator failed to initialize'
    @allocator.allocate!
    @next_dose = Time.zone.parse('2014-10-1 08:00') 
  end

  test "allocator assigns times correctly" do
    all_doses = @reminder.enumerate_doses
    all_doses.count.times do |i|
      assert_equal all_doses[i].time, @next_dose, "#Iteration #{i}: {all_doses[i].time} is not equal to #{@next_dose}"
      @next_dose += 8.hours
    end
  end

  test "allocates correctly after editing reminder rule" do
    rr = @reminder.reminder_rules.last
    rr.time_of_day = "16:05"
    rr.save
    @allocator.allocate!

    all_doses = @reminder.enumerate_doses
    all_doses.count.times do |i|
      assert_equal all_doses[i].time, @next_dose, "Iteration #{i}: #{all_doses[i].time} is not equal to #{@next_dose}"
      @next_dose += 8.hours
      @next_dose += 5.minutes if i%3 == 0
      @next_dose -= 5.minutes if all_doses[i].time.min == 5
    end
  end

  test "allocates correctly after deleting a rule" do
    @reminder.reminder_rules.last.destroy
    @reminder.reload
    @allocator.allocate!

    all_doses = @reminder.enumerate_doses
    all_doses.count.times do |i|
      assert_equal all_doses[i].time, @next_dose, "Iteration #{i}: #{all_doses[i].time} is not equal to #{@next_dose}"
      @next_dose += 8.hours
      @next_dose += 8.hours if i%2 == 0
    end
  end

  test "alloates correctly after inserting a rule" do
    new_rule = reminder_rules(:new_rule)
    new_rule.reminder = @reminder
    new_rule.save
    @reminder.reload
    @allocator.allocate!

    all_doses = @reminder.enumerate_doses
    all_doses.count.times do |i|
      assert_equal all_doses[i].time, @next_dose, "Iteration #{i}: #{all_doses[i].time} is not equal to #{@next_dose}"
      if (i-1)%4 == 0
        @next_dose += 5.minutes
      else
        @next_dose += 8.hours
        @next_dose -= 5.minutes if all_doses[i].time.min == 5
      end
    end
  end
end
