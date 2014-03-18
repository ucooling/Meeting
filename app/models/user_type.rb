class UserType < ActiveRecord::Base
  attr_accessible :key, :value
  
  validates  :key,   :uniqueness => true,    :presence => true
  validates  :value, :uniqueness => true,    :presence => true
end
