require 'test_helper'

class ReminderRulesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in :user, @user 
    @reminder_rule = reminder_rules(:one)
    @reminder_rule.reminder.reminder_rules.each do |rr|
      rr.set_schedule
      rr.save
    end
    @reminder_rule.reminder.assign_counts
    CountAllocator.new(@reminder_rule.reminder).allocate!
  end

  # no index action for reminder_rules
  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:reminder_rules)
  # end

  # no new action for reminder_rules
  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # no create action for reminder_rules
  # test "should create reminder_rule and redirect to parent reminder" do
  #   assert_difference('ReminderRule.count') do
  #     post :create, reminder_rule: { day_of_week: 7, time_of_day: "12:00", textable: true, emailable: true, reminder_id: 2 }
  #   end

  #   assert_redirected_to reminder_path(assigns(:reminder_rule).reminder)
  # end

  # no show action for reminder_rules
  # test "should show reminder_rule" do
  #   get :show, id: @reminder_rule
  #   assert_response :success
  # end

  test "should get edit" do
    get :edit, id: @reminder_rule.id
    assert_response :success
  end

  test "should update reminder_rule" do
    patch :update, id: @reminder_rule, reminder_rule: { day_of_week: 7, time_of_day: "12:00", textable: "1", emailable: "1", reminder_id: 2 }
    assert_redirected_to reminder_path(assigns(:reminder_rule).reminder)
  end

  test "should destroy reminder_rule and redirect to former parent" do
    reminder_id = @reminder_rule.reminder.id 
    assert_difference('ReminderRule.count', -1) do
      delete :destroy, id: @reminder_rule
    end

    assert_redirected_to reminder_path(reminder_id)
  end
end
