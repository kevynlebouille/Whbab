require 'test_helper'

class ArmyListChoicesControllerTest < ActionController::TestCase
  setup do
    @army_list_choice = army_list_choices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:army_list_choices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create army_list_choice" do
    assert_difference('ArmyListChoice.count') do
      post :create, :army_list_choice => @army_list_choice.attributes
    end

    assert_redirected_to army_list_choice_path(assigns(:army_list_choice))
  end

  test "should show army_list_choice" do
    get :show, :id => @army_list_choice.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @army_list_choice.to_param
    assert_response :success
  end

  test "should update army_list_choice" do
    put :update, :id => @army_list_choice.to_param, :army_list_choice => @army_list_choice.attributes
    assert_redirected_to army_list_choice_path(assigns(:army_list_choice))
  end

  test "should destroy army_list_choice" do
    assert_difference('ArmyListChoice.count', -1) do
      delete :destroy, :id => @army_list_choice.to_param
    end

    assert_redirected_to army_list_choices_path
  end
end
