require 'test_helper'

class ProvisionsControllerTest < ActionController::TestCase
  setup do
    @provision = provisions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:provisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provision" do
    assert_difference('Provision.count') do
      post :create, provision: { machine_id: @provision.machine_id, service_id: @provision.service_id, start_port: @provision.start_port }
    end

    assert_redirected_to provision_path(assigns(:provision))
  end

  test "should show provision" do
    get :show, id: @provision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @provision
    assert_response :success
  end

  test "should update provision" do
    put :update, id: @provision, provision: { machine_id: @provision.machine_id, service_id: @provision.service_id, start_port: @provision.start_port }
    assert_redirected_to provision_path(assigns(:provision))
  end

  test "should destroy provision" do
    assert_difference('Provision.count', -1) do
      delete :destroy, id: @provision
    end

    assert_redirected_to provisions_path
  end
end
