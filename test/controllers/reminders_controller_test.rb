require 'test_helper'

class RemindersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in :user, @user 
    @reminder = reminders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reminders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reminder" do
    assert_difference('Reminder.count') do
      post :create, reminder: { doses: @reminder.doses, notes: @reminder.notes, start: @reminder.start, title: @reminder.title }
    end

    assert_redirected_to reminder_path(assigns(:reminder))
  end

  test "should show reminder" do
    @reminder.reminder_rules.each do |rr|
      rr.set_schedule
      rr.save
    end
    get :show, id: @reminder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reminder
    assert_response :success
  end

  test "should update reminder" do
    @reminder.reminder_rules.each do |rr|
      rr.set_schedule
      rr.save
    end
    patch :update, id: @reminder, reminder: { doses: @reminder.doses, notes: @reminder.notes, start: @reminder.start, title: @reminder.title }
    assert_redirected_to reminder_path(assigns(:reminder))
  end

  test "should destroy reminder" do
    assert_difference('Reminder.count', -1) do
      delete :destroy, id: @reminder
    end

    assert_redirected_to reminders_path
  end
end
