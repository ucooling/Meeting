class AdminController < ApplicationController
	def login
    user = User.find_by_number(params[:number])
    session[:user_id] = nil
    if user && user.admin == true && user.password == params[:user_password]
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect_to :controller=>"users", :action=>"index"
    end
    if user && user.admin ==nil  && user.password == params[:user_password]
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect_to :controller=>"schedules",:action=>"index"
    end
    if !user
      render "login"
    end
	end

  def loginout
    session[:user_id] = nil
    redirect_to :action=>"login"
  end
  
  def modifypwd
    @user = User.find(session[:user_id])   
    if params["btnchgpwd"]
      pwd1 = params[:password1]
      pwd2 = params[:password2] 
      if pwd1 == pwd2
        @user.update_attribute(:password,params[:password1])
        @ok = "Ok !"
      else
        @error = "Password not consistent !"
      end
    end
    render :layout => "home"
  end


end