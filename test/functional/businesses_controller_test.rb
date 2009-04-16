require 'test_helper'

class BusinessesControllerTest < ActionController::TestCase
  setup :login_quentin
  
  def test_should_get_index
    get :index
    assert_redirected_to :controller => "administration"
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_business
    assert_difference('Business.count') do
      post :create, :business => {
        :nick => "new",
        :name => "New Company LLC",
        :country_id => countries(:ro).id
      }
    end
    assert_redirected_to business_path(assigns(:business))
  end

  def test_should_show_business
    get :show, :id => businesses(:snbstyle).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => businesses(:snbstyle).id
    assert_response :success
  end

# => See bellow, it should fail... whilst this still passes
#  def test_should_fail_get_edit_if_user_is_not_associated_with_the_business
#    get :edit, :id => businesses(:penmach).id
#    assert_response :success
#  end  

  def test_should_update_business
    put :update, :id => businesses(:snbstyle).id, :business => {
      :id => businesses(:snbstyle).id,
      :nick => "snbstyle",
      :name => "NO TAXES LLC",
      :country_id => countries(:ae).id      
    }
    assert_redirected_to business_path(assigns(:business))
  end

  def test_should_destroy_business
    assert_difference('Business.count', -1) do
      delete :destroy, :id => businesses(:otms).id
    end
    assert_redirected_to businesses_path
  end
  
end
