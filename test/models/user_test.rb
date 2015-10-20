require 'test_helper'

class UserTest < ActiveSupport::TestCase
	#include Devise::TestHelpers
  def setup
  	@user1 = User.new(email: "yuanxue68@gmail.com", password: "password", password_confirmation: "password")
  	@user2 = User.new(email: "yuanxue68@gmail.com", password: "password", password_confirmation: "password1")
  end

  test "should be valid" do
  	assert @user1.valid?
  end

  test "unmatching password should not be valid" do
  	assert_not @user2.valid?
  end

  test "empty email should not be valid" do
  	@user1.email="   "
  	assert_not @user1.valid?
  end
end
