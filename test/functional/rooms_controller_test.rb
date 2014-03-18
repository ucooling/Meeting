require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  setup do
    @room = rooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room" do
    assert_difference('Room.count') do
      post :create, room: { air_condition: @room.air_condition, max_volume: @room.max_volume, pc: @room.pc, projector: @room.projector, room_floor: @room.room_floor, room_name: @room.room_name, sound_proofing: @room.sound_proofing, tel: @room.tel, tel_num: @room.tel_num, tv: @room.tv, tv_ip: @room.tv_ip, webcam: @room.webcam, whiteboard: @room.whiteboard }
    end

    assert_redirected_to room_path(assigns(:room))
  end

  test "should show room" do
    get :show, id: @room
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @room
    assert_response :success
  end

  test "should update room" do
    put :update, id: @room, room: { air_condition: @room.air_condition, max_volume: @room.max_volume, pc: @room.pc, projector: @room.projector, room_floor: @room.room_floor, room_name: @room.room_name, sound_proofing: @room.sound_proofing, tel: @room.tel, tel_num: @room.tel_num, tv: @room.tv, tv_ip: @room.tv_ip, webcam: @room.webcam, whiteboard: @room.whiteboard }
    assert_redirected_to room_path(assigns(:room))
  end

  test "should destroy room" do
    assert_difference('Room.count', -1) do
      delete :destroy, id: @room
    end

    assert_redirected_to rooms_path
  end
end
