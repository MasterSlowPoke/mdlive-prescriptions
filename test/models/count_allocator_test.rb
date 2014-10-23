require 'test_helper.rb'

class CountAllocatorTest < ActiveSupport::TestCase
  setup do
    @reminder = reminders(:three_rules)
    @allocator = CountAllocator.new(@reminder)
    refute_nil @reminder
    refute_nil @allocator 
  end

  test "allocator assigns times correctly" do
    @allocator.allocate!
    all_doses = @reminder.enumerate_doses
    next_dose = Time.zone.parse('2014-10-1 08:00') 
    all_doses.count.times do |i|
      assert_equal all_doses[i].time, next_dose, "#{@reminder.next_dose} is not equal to #{next_dose}"
      next_dose += 8.hours
    end
  end
end
