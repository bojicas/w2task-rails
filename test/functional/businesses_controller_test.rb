require 'test_helper'

class BusinessesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:businesses)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_business
    assert_difference('Business.count') do
      post :create, :business => { }
    end

    assert_redirected_to business_path(assigns(:business))
  end

  def test_should_show_business
    get :show, :id => businesses(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => businesses(:one).id
    assert_response :success
  end

  def test_should_update_business
    put :update, :id => businesses(:one).id, :business => { }
    assert_redirected_to business_path(assigns(:business))
  end

  def test_should_destroy_business
    assert_difference('Business.count', -1) do
      delete :destroy, :id => businesses(:one).id
    end

    assert_redirected_to businesses_path
  end
end
