require 'test_helper'
include Devise::TestHelpers
class StaticPagesControllerTest < ActionController::TestCase
	include Devise::TestHelpers
  test "should get home" do
    get :home
    assert_response :success
  end

end
