require 'test_helper'

class ReminderItemsControllerTest < ActionController::TestCase
  setup do
    @reminder_item = reminder_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reminder_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reminder_item" do
    assert_difference('ReminderItem.count') do
      post :create, reminder_item: { missed: @reminder_item.missed, reminder_id_id: @reminder_item.reminder_id_id, scheduled_time: @reminder_item.scheduled_time, taken: @reminder_item.taken }
    end

    assert_redirected_to reminder_item_path(assigns(:reminder_item))
  end

  test "should show reminder_item" do
    get :show, id: @reminder_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reminder_item
    assert_response :success
  end

  test "should update reminder_item" do
    patch :update, id: @reminder_item, reminder_item: { missed: @reminder_item.missed, reminder_id_id: @reminder_item.reminder_id_id, scheduled_time: @reminder_item.scheduled_time, taken: @reminder_item.taken }
    assert_redirected_to reminder_item_path(assigns(:reminder_item))
  end

  test "should destroy reminder_item" do
    assert_difference('ReminderItem.count', -1) do
      delete :destroy, id: @reminder_item
    end

    assert_redirected_to reminder_items_path
  end
end
