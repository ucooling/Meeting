class Status < ActiveRecord::Base
  attr_accessible :end_time, :room_name, :schedule_day, :start_time, :scheduleid
end
