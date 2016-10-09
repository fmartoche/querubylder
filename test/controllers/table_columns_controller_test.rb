require 'test_helper'

class TableColumnsControllerTest < ActionController::TestCase
  setup do
    @table_column = table_columns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:table_columns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create table_column" do
    assert_difference('TableColumn.count') do
      post :create, table_column: { name: @table_column.name, type: @table_column.type }
    end

    assert_redirected_to table_column_path(assigns(:table_column))
  end

  test "should show table_column" do
    get :show, id: @table_column
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @table_column
    assert_response :success
  end

  test "should update table_column" do
    patch :update, id: @table_column, table_column: { name: @table_column.name, type: @table_column.type }
    assert_redirected_to table_column_path(assigns(:table_column))
  end

  test "should destroy table_column" do
    assert_difference('TableColumn.count', -1) do
      delete :destroy, id: @table_column
    end

    assert_redirected_to table_columns_path
  end
end
