require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  setup :login_quentin
  
  test "should show all businesses and only those to which logged in user is part of" do
    get :index
    assert_response :success
    assert_not_nil assigns(:businesses) # only in this particular case, and particular fixtures
    assert_equal(users(:quentin).businesses, assigns(:businesses))
    # if bojicas is a business which quentin (current user) can access the fail
    assert_not_equal(businesses('bojicas'), assigns(:businesses)[0])
  end
  
  test"should show all users and only those assigned to the current business" do
    get :index
    assert_response :success
    # TODO: not finished yet
  end
end
