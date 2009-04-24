require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  setup :login_quentin
  
  test "should show all businesses to witch current user is part of" do
    #current_user = users.find_by_id(session[:user_id])
    assert_equal(users(:quentin).businesses.nick, "snbstyle")
  end
  
  test "should show all businesses of the current user" do
    assert true
  end
end
