require 'test_helper'

class AllowedInputsControllerTest < ActionController::TestCase
  setup do
    @allowed_input = allowed_inputs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:allowed_inputs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create allowed_input" do
    assert_difference('AllowedInput.count') do
      post :create, allowed_input: { alias: @allowed_input.alias, input_type: @allowed_input.input_type, name: @allowed_input.name }
    end

    assert_redirected_to allowed_input_path(assigns(:allowed_input))
  end

  test "should show allowed_input" do
    get :show, id: @allowed_input
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @allowed_input
    assert_response :success
  end

  test "should update allowed_input" do
    patch :update, id: @allowed_input, allowed_input: { alias: @allowed_input.alias, input_type: @allowed_input.input_type, name: @allowed_input.name }
    assert_redirected_to allowed_input_path(assigns(:allowed_input))
  end

  test "should destroy allowed_input" do
    assert_difference('AllowedInput.count', -1) do
      delete :destroy, id: @allowed_input
    end

    assert_redirected_to allowed_inputs_path
  end
end
