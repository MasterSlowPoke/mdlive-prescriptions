require 'test_helper.rb'

class CountAllocatorTest < ActiveSupport::TestCase
  setup do
    @reminder = reminders(:three_rules)
    @allocator = CountAllocator.new(@reminder)
    refute_nil @reminder
    refute_nil @allocator 
  end
end
