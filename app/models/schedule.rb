class Schedule < ActiveRecord::Base
  attr_accessible :comment, :end_time, :room_id, :schedule_day, :start_time, :user_id, :title
  belongs_to :user
  belongs_to :room

end
