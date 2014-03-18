class Room < ActiveRecord::Base
  attr_accessible :air_condition, :max_volume, :pc, :projector, :room_floor, :room_name, :sound_proofing, :tel, :tel_num, :tv, :tv_ip, :webcam, :whiteboard
  has_many :schedules,:dependent => :destroy
end
