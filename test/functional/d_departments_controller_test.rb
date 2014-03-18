require 'test_helper'

class DDepartmentsControllerTest < ActionController::TestCase
  setup do
    @d_department = d_departments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:d_departments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create d_department" do
    assert_difference('DDepartment.count') do
      post :create, d_department: { key: @d_department.key, value: @d_department.value }
    end

    assert_redirected_to d_department_path(assigns(:d_department))
  end

  test "should show d_department" do
    get :show, id: @d_department
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @d_department
    assert_response :success
  end

  test "should update d_department" do
    put :update, id: @d_department, d_department: { key: @d_department.key, value: @d_department.value }
    assert_redirected_to d_department_path(assigns(:d_department))
  end

  test "should destroy d_department" do
    assert_difference('DDepartment.count', -1) do
      delete :destroy, id: @d_department
    end

    assert_redirected_to d_departments_path
  end
end
