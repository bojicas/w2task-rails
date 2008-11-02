require 'test_helper'

class EffortsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:efforts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_effort
    assert_difference('Effort.count') do
      post :create, :effort => { }
    end

    assert_redirected_to effort_path(assigns(:effort))
  end

  def test_should_show_effort
    get :show, :id => efforts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => efforts(:one).id
    assert_response :success
  end

  def test_should_update_effort
    put :update, :id => efforts(:one).id, :effort => { }
    assert_redirected_to effort_path(assigns(:effort))
  end

  def test_should_destroy_effort
    assert_difference('Effort.count', -1) do
      delete :destroy, :id => efforts(:one).id
    end

    assert_redirected_to efforts_path
  end
end
