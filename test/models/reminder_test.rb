require 'test_helper'

class ReminderTest < ActiveSupport::TestCase
  setup do 
    @reminder = reminders(:one)
    assert @reminder.save, "problem with reminder fixture"
  end

  test "doses must be greater than zero" do
    [nil, -1, "none", 0, -100].each do |input|
      @reminder.doses = input
      refute @reminder.save, "doses can be set to #{input}"
    end
  end

  test "title can not be blank" do
    [nil, ""].each do |input|
      @reminder.title = input
      refute @reminder.save, "title can be set to #{input}"
    end
  end

  test "only reminders with rules can be exported" do
    assert @reminder.exportable?, "reminder with rules is not exportable"
    refute reminders(:reminder_without_rules).exportable?, "reminder without rules is exportable"
  end

  test "destroy all child rules on destruction" do
    assert @reminder.reminder_rules.count > 0, "reminder has no rules set"
    ids = @reminder.reminder_rules.map { |i| i.id }
    @reminder.destroy
    ids.each do |id|
      # find by doesn't raise errors
      refute ReminderRule.find_by(id: id), "reminder rule \##{id} still exists" 
    end
  end
end
