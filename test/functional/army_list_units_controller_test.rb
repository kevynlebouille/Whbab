require 'test_helper'

class ArmyListUnitsControllerTest < ActionController::TestCase
  setup do
    @army_list_unit = army_list_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:army_list_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create army_list_unit" do
    assert_difference('ArmyListUnit.count') do
      post :create, :army_list_unit => @army_list_unit.attributes
    end

    assert_redirected_to army_list_unit_path(assigns(:army_list_unit))
  end

  test "should show army_list_unit" do
    get :show, :id => @army_list_unit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @army_list_unit.to_param
    assert_response :success
  end

  test "should update army_list_unit" do
    put :update, :id => @army_list_unit.to_param, :army_list_unit => @army_list_unit.attributes
    assert_redirected_to army_list_unit_path(assigns(:army_list_unit))
  end

  test "should destroy army_list_unit" do
    assert_difference('ArmyListUnit.count', -1) do
      delete :destroy, :id => @army_list_unit.to_param
    end

    assert_redirected_to army_list_units_path
  end
end
