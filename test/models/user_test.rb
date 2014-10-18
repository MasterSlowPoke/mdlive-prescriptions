require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do 
    @user = users(:one)
    assert @user.save, "user object not savable"
  end

  test "user name never nil" do
    @user.name = nil
    refute @user.save, "user name allowed to be nil"
  end

  test "user email never nil" do
  	@user.email = nil
    refute @user.save, "user email allowed to be nil"
  end

  test "user phone never less than 10 digits" do
    [1,-3,123456789,999999999,5555555].each do |input|
      @user.phone = input
      refute @user.save, "phone number #{input} was allowed"
    end
  end

  test "phone strips out all non-digit characters" do
    ["(555) 555-5555","555.555.5555","+555>555>5555", "my phone number is area code 555, number 555-5555"].each do |input|
      @user.phone = input
      assert @user.phone = 5555555555, "phone number #{input} was allowed"
    end
  end

  test "password and password_confirmation must match" do
    @user.password = "new_password"
    @user.password_confirmation = "not_the_same_thing"
    refute @user.save, "passwords didn't match yet the user was allowed to save"
  end
end
