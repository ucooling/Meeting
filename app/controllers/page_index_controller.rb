class PageIndexController < ApplicationController
	layout "home"
	#访问网站的首页
  def index
    @page = "我是首页"
  end

end