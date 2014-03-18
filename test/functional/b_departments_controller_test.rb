require 'test_helper'

class BDepartmentsControllerTest < ActionController::TestCase
  setup do
    @b_department = b_departments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:b_departments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create b_department" do
    assert_difference('BDepartment.count') do
      post :create, b_department: { key: @b_department.key, value: @b_department.value }
    end

    assert_redirected_to b_department_path(assigns(:b_department))
  end

  test "should show b_department" do
    get :show, id: @b_department
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @b_department
    assert_response :success
  end

  test "should update b_department" do
    put :update, id: @b_department, b_department: { key: @b_department.key, value: @b_department.value }
    assert_redirected_to b_department_path(assigns(:b_department))
  end

  test "should destroy b_department" do
    assert_difference('BDepartment.count', -1) do
      delete :destroy, id: @b_department
    end

    assert_redirected_to b_departments_path
  end
end
