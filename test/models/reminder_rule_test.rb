require 'test_helper'

class ReminderRuleTest < ActiveSupport::TestCase
  setup do
    @reminder_rule = reminder_rules(:one)
    assert @reminder_rule.save, "problem with the fixture: #{@reminder_rule.errors.first}"
  end

  test "time_of_day must look like hh:mm" do
    [nil, "10:00 PM", "30:00", "ten o'clock", "10-22", "12:66"].each do |input|
      @reminder_rule.time_of_day = input
      refute @reminder_rule.save, "invalid time '#{input}' was allowed to be saved"
    end
  end

  test "emailable must not be nil" do
    @reminder_rule.emailable = nil
    refute @reminder_rule.save, "emailable is nil"
  end

  test "textable must not be nil" do
    @reminder_rule.textable = nil
    refute @reminder_rule.save, "textable is nil"
  end

  test "day_of_week must be integer and between 0 and 7" do
    [nil, -1, 8, "wednesday", 5.5].each do |input|
      @reminder_rule.day_of_week = input
      refute @reminder_rule.save, "invalid day_of_week '#{input}' was allowed to be saved"
    end
  end

  test "ical_freq is correct based on day_of_week" do
    @reminder_rule.day_of_week = 7
    assert @reminder_rule.ical_freq == "DAILY", "Everyday should be DAILY"
    (0..6).each do |day|
      @reminder_rule.day_of_week = day
      assert @reminder_rule.ical_freq == "WEEKLY", "#{day} should be WEEKLY"
    end
  end
end
