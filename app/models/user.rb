#encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :admin, :b_department, :d_department, :email, :name, :number, :password, :position, :tel, :user_type, :superuser
  has_many :schedules,:dependent => :destroy
  validates :number, :presence => {:message => "工号不能为空"}
  validates :email, :presence => {:message => "邮件不能为空"}
  validates :number, :uniqueness => {:case_sensitive => false,:message => "工号已存在"}
  validates :email, :uniqueness => {:case_sensitive => false,:message => "邮件已存在"}
end