class SchedulesController < ApplicationController
	layout "home"
	#index page
	def index
		@user = User.find(session[:user_id])
		#@rooms = Room.order("room_name ASC")
		@arr={
    1 => "8:00",
    2 => "",
    3 => "9:00",
    4 => "",
    5 => "10:00",
    6 => "",
    7 => "11:00",
    8 => "", 
    9 => "12:00",
    10 => "",
    11 => "13:00",
    12 => "",
    13 => "14:00",
    14 => "",
    15 => "15:00",
    16 => "",
    17 => "16:00",
    18 => "",
    19 => "17:00",
    20 => "",
    21 => "18:00"
    }
    @room = []
    #rooms = Room.find(:all,:conditions => ["room_floor = ?",2],:order => "room_name ASC")
    rooms = Room.find(:all)
    rooms.each do |r|
      @room << r.room_name
    end 
		#@params = paramsforcolor("2013-08-29",2)
		@date = params["datetime"]
		if !@date
        @date = Time.new.to_date.to_s
    end
		@params = paramsforcolor(@date,2)
		if params["btnsearch"]
#		  if !@date
#		    @date = Time.new.to_date.to_s
#		  end
		  @selected = {}
		  @selected["projector"] = params["projector"]
		  @selected["whiteboard"] = params["whiteboard"]
		  @selected["pc"] = params["pc"]
		  @selected["webcam"] = params["webcam"]
		  @selected["tel"] = params["tel"]
		  @selected["tv"] = params["tv"]
		  @selected["air_condition"] = params["air_condition"]
		  @selected["sound_proofing"] = params["sound_proofing"]
		  @selectday = params[:date]
		  @selectfloor = params["schedule_condition"]
		  @details = searchforindex(@selectday,@selected,@selectfloor.to_i)
		  @room = @details["room"]
		  @params = @details["schedule"]
		end
		#@params = ["1-0","2-0","3-0","4-0","5-0"]
		#@params = [{"user"=>"test1","time"=>["1-0","2-0","3-0"]},{"user"=>"test2","time"=>["4-1"]}]
		
  end
	#add schedule
	def add_schedule
    @user = User.find(session[:user_id])
    @allroom = Room.find(:all)
    @rooms = []
    @allroom.each do |r|
      @rooms << r.room_name
    end
    if params["btnnew"]
      scheduledetail = {}
      statusdetail = {}
      scheduledetail["title"] = params[:title]
      scheduledetail["schedule_day"] = params[:schedule_day]
      scheduledetail["start_time"] = params[:start_time]
      scheduledetail["end_time"] = params[:end_time]
      scheduledetail["comment"] = params[:comment]
      statusdetail["room_name"] = params[:room_name]
      statusdetail["schedule_day"] = params[:schedule_day]
      statusdetail["start_time"] = params[:start_time]
      statusdetail["end_time"] = params[:end_time]
      if create_schedule_conflict(params[:room_name],params[:schedule_day],params[:start_time],params[:end_time])
        @error = "Time Conflict !"
      else
        createschedule(@user.id,params[:room_name],scheduledetail,statusdetail)
        @ok = "Succeed !"
      end 
    end   
	end
	
	#test loop add_schedule
	def loop_add_schedule
	  @user = User.find(session[:user_id])
	  @allroom = Room.find(:all)
	  @rooms = []
	  @allroom.each do |r|
	    @rooms << r.room_name
	  end
	  @week = ["7","1","2","3","4","5","6"]
	  @month = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
	  @i = 0
    if params["btnloop"]
      @paramsweek = params["loopday"]
      @time = params[:looptime]
      scheduledetail = {}
      statusdetail = {}
      scheduledetail["title"] = params[:title]
      scheduledetail["schedule_day"] = params[:schedule_day]
      scheduledetail["start_time"] = params[:start_time]
      scheduledetail["end_time"] = params[:end_time]
      scheduledetail["comment"] = params[:comment]
      statusdetail["room_name"] = params[:room_name]
      statusdetail["schedule_day"] = params[:schedule_day]
      statusdetail["start_time"] = params[:start_time]
      statusdetail["end_time"] = params[:end_time]
      if !@paramsweek
        #@info = "Please select the loopday !"
        if create_schedule_conflict(params[:room_name],params[:schedule_day],params[:start_time],params[:end_time])
          @error = "Time Conflict !"
        else
          createschedule(@user.id,params[:room_name],scheduledetail,statusdetail)
          @ok = "Succeed !"
        end
      else
        @conflictday = []
        @dayarray = []
        @paramsweek.each do |w|
          w = w.to_i
          @dayarray << weekloop(params[:schedule_day],@time.to_i,w)
        end
        @dayarray.flatten!
        @dayarray.each do |d|
          if create_schedule_conflict(params[:room_name],d,params[:start_time],params[:end_time])
            #@error = "Time Conflict !" + "The conflict day is " + d
            #break
            @conflictday << d
          else
            scheduledetail["schedule_day"] = d
            statusdetail["schedule_day"] = d
            createschedule(@user.id,params[:room_name],scheduledetail,statusdetail)
            @ok = "Succeed !"
          end
          #scheduledetail["schedule_day"] = d
          #createschedule(@user.id,params[:room_name],scheduledetail,statusdetail)
          #@ok = "Succeed !"
        end
        @tt = "" 
        unless @conflictday.empty?
          @conflictday.each do |day|
            @tt =@tt + day + " "
          end
          if @tt 
            @error = "Time Conflict !" + "The conflict day is " + @tt
          end        
        end
      end
      
      
        #createschedule(@user.id,params[:room_name],scheduledetail,statusdetail)
        #@ok = "Succeed !"
#      end 
    end
	end
	
	
	
	#show schedule
  def my_schedule
    @user = User.find(session[:user_id])
    #@schedules = Schedule.find_all_by_user_id(@user.id)
    @schedules = Schedule.where(:user_id => @user.id).paginate(:page => params[:page], :per_page => 12).order('schedule_day ASC')
    #@tt = paramsforcolor("2013-08-19",2)
    #@params = paramsforcolor("2013-08-29",2)
    if params["btnselect"]
      @scheduleids = params["scheduleid"]
      if @scheduleids
        @scheduleids.each do |s|
          id = s.to_i
          deleteschedule(id)
        end
      else
        @info = "Please select at least one item !"
      end
    end
  end
  #delete schedule
  def delete_schedule
    @schedule = Schedule.find(params[:id])
    #delete status
    @status = Status.find_by_scheduleid(@schedule.id)
    @status.delete
    @schedule.delete
    redirect_to :back
  end
  #modify schedule
  def update_schedule
    @user = User.find(session[:user_id])
    @schedule = Schedule.find(params[:id])
    @scheduledetail = {}
    @scheduledetail["title"] = @schedule.title
    @scheduledetail["room_name"] = Room.find(@schedule.room_id).room_name
    @scheduledetail["schedule_day"] = @schedule.schedule_day
    @scheduledetail["start_time"] = @schedule.start_time
    @scheduledetail["end_time"] = @schedule.end_time
    @scheduledetail["comment"] = @schedule.comment
    if params["btnupdate"]
      @detail = {}
      @detail["title"] = params[:title]
      @detail["schedule_day"] = params[:schedule_day]
      @detail["start_time"] = params[:start_time]
      @detail["end_time"] = params[:end_time]
      @detail["comment"] = params[:comment]
      @detail["room_name"] = params[:room_name]
      @status = Status.find_by_scheduleid(@schedule.id)
      @status.delete
      if create_schedule_conflict(@detail["room_name"],@detail["schedule_day"],@detail["start_time"],@detail["end_time"])
        @error = "Time Conflict !"
        scrbslog("Time Conflict !")
      else
        updateschedule(@schedule.id,@detail)
        redirect_to :action =>"my_schedule"       
      end
    end
  end

  #find schedule_room
  def schedule_find
    redirect_to :action=>"index"
  end

private
  #create new schedule and create new room_status
  def createschedule(uid,rname,scparams,stparams)
    scrbslog("======Begin to create a new schedule======")
    @user = User.find(uid)
    scrbslog("Author:" + @user.name)
    @room = Room.find_by_room_name(rname)   
    @schedule = Schedule.create(scparams)
    @user.schedules << @schedule
    @room.schedules << @schedule
    stparams["scheduleid"]=@schedule.id
    @status = Status.create(stparams)
    scrbslog(scparams)
    scrbslog("======End to create a new schedule======")
  end
  #update schedule and update status
  def updateschedule(scid,params)
    scrbslog("======Begin to update a schedule======")
    @schedule = Schedule.find(scid)
    @user = User.find(@schedule.user_id)
    scrbslog("Author:" + @user.name)
    room_id = Room.find_by_room_name(params["room_name"]).id
    @schedule.update_attributes(:schedule_day=>params["schedule_day"],:start_time=>params["start_time"],:end_time=>params["end_time"],:comment=>params["comment"],:room_id => room_id,:title =>params["title"] )
    Status.create(:room_name=>params["room_name"],:schedule_day=>params["schedule_day"],:start_time=>params["start_time"],:end_time=>params["end_time"],:scheduleid=>scid)
    scrbslog(params)
    scrbslog("======End to update a schedule======")
  end
  #delete schedule and delete status
  def deleteschedule(scid)
    scrbslog("======Begin to delete a schedule======")
    @schedule = Schedule.find(scid)
    @user = User.find(@schedule.user_id)
    scrbslog("Author:" + @user.name)
    @status = Status.find_by_scheduleid(@schedule.id)
    scrbslog(@schedule.title + " " + @schedule.schedule_day + " " + @schedule.start_time + " " + @schedule.end_time + " " + @schedule.comment + " " + @schedule.room_id.to_s)
    @status.delete
    @schedule.delete   
    scrbslog("======Begin to delete a schedule======")
  end
  #solve schedule_time_conflict
  def time_conflict(stime,etime,oldstime,oldetime)
    basic={"8:00"=>-1,"8:30"=>0,"9:00"=>1,"9:30"=>2,"10:00"=>3,"10:30"=>4,"11:00"=>5,"11:30"=>6,"12:00"=>7,"12:30"=>8,"13:00"=>9,"13:30"=>10,"14:00"=>11,"14:30"=>12,"15:00"=>13,"15:30"=>14,"16:00"=>15,"16:30"=>16,"17:00"=>17,"17:30"=>18,"18:00"=>19}
    flag=false
    if basic[stime] <= basic[oldstime] and basic[etime] > basic[oldstime]
      flag=true
    elsif basic[stime] > basic[oldstime] and basic[stime]  < basic[oldetime]
      flag=true
    end 
    return flag
  end
  #solve schedule_time_conflict,include meeting , day
  def create_schedule_conflict(rname,day,stime,etime)
    #flag=false
    @statuss=Status.find(:all,:conditions => ["room_name = ? AND schedule_day = ?",rname,day])
    if @statuss
      @statuss.each do |s|
        if time_conflict(stime,etime,s["start_time"],s["end_time"])
          return true
        end
      end
    end
    return false
  end
  #get the params for index color
  def paramsforcolor(day,roomfloor)
    schedules = Schedule.find_all_by_schedule_day(day)
    #rooms = Room.find_all_by_room_floor(roomfloor).order(:room_name).reverse_order
    #rooms = Room.find(:all,:conditions => ["room_floor = ?",roomfloor],:order => "room_name ASC")
    rooms = Room.find(:all)
    room = {}
    i = 0
    rooms.each do |r|
      room[r.room_name] = i
      i = i+1
    end
    time={
    "8:00" => 1,
    "8:30" => 2,
    "9:00" => 3,
    "9:30" => 4,
    "10:00" => 5,
    "10:30" => 6,
    "11:00" => 7,
    "11:30" => 8,
    "12:00" => 9,
    "12:30" => 10,
    "13:00" => 11,
    "13:30" => 12,
    "14:00" => 13,
    "14:30" => 14,
    "15:00" => 15,
    "15:30" => 16,
    "16:00" => 17,
    "16:30" => 18,
    "17:00" => 19,
    "17:30" => 20,
    "18:00" => 21
    }
    #@room = ["E201","E202","E203","E204","W205","W206","W207","W208","W209","W210"]
#    room = {
#      "E201" => 0,
#      "E202" => 1,
#      "E203" => 2,
#      "E204" => 3,
#      "W205" => 4,
#      "W206" => 5,
#      "W207" => 6,
#      "W208" => 7,
#      "W209" => 8,
#      "W210" => 9
#    }
    params = []
    schedules.each do |s|
      param = {}
      user = User.find(s.user_id)
      param["username"] = user.name
      param["time"] = []
      stime = s.start_time
      etime = s.end_time
      roomname = (Room.find(s.room_id)).room_name
      roomij = room[roomname]
      i = time[stime]
      j = time[etime]
      while i<j do
        #params << (i.to_s + "-" + roomij.to_s)
        param["time"] << (i.to_s + "-" + roomij.to_s)
        i = i+1
      end
      params << param
    end
    return params
  end
  #loop with week ; loopday:Integer ;return a dayarray[].
  #week::wday [0,1,2,3,4,5,6]
  def weekloop(sday,looptime,loopday)
    @sday = sday.to_date
    if @sday.wday < loopday
      @sday = @sday + (loopday - @sday.wday)
    elsif @sday.wday > loopday
      @sday = @sday - (@sday.wday - loopday) + 7
    end
    dayarray = []
    dayarray << @sday.to_s
    for i in 1...looptime do
      @sday = @sday + 7
      dayarray << @sday.to_date.to_s
    end
    return dayarray
  end
  #loop with month ; return a dayarray[].
  #※※※※※※※※※※  Not yet solve the problem that the loopday not in @month
  def monthloop(sday,looptime,loopday)
    #@yeardays = [31,28,31,30,31,30,31,31,30,31,30,31]
    #@leapyeardays = [31,28,31,30,31,30,31,31,30,31,30,31]
    @year = sday.to_date.year
    @month = sday.to_date.month
    @day = sday.to_date.day
    dayarray = []
    if loopday < 10 
      @strday = "0" + loopday.to_s
    else
      @strday = loopday.to_s
    end
    if @day > loopday
      @month = @month + 1
      if @month > 12
        @year = @year + 1
      end 
    end
    if @month < 10
      @omonth = "0" + @month.to_s
    else
      @omonth = @month.to_s
    end
    dayarray << (@year.to_s + '-' + @omonth + '-' + @strday)
    for i in 1...looptime do
      @month = @month + 1
      if @month > 12
        @year = @year +1
        @month = 1
      end
      if @month < 10
        @strmonth = "0" + @month.to_s
      else
        @strmonth = @month.to_s
      end
      @strdate = @year.to_s + "-" + @strmonth + "-" + @strday
      dayarray << @strdate
    end
    return dayarray
  end
  #data operate log
  def scrbslog(content)
    if File.exist?("..\\Meeting\\log\\scrbs.log")
      mylog = File.open("..\\Meeting\\log\\scrbs.log","a")
    else
      mylog = File.new("..\\Meeting\\log\\scrbs.log","a")
    end
    mylog.puts (Time.new).to_s + "*********************"
    mylog.puts content
    mylog.close
  end
  #search for index
  def searchforindex(day,select,floor)
    params = {}
    params["schedule"] = paramsforcolor(day,floor)
    room = []
    new = {}
    select.each do |key,value|
      if value == "1"
        new[key] = value
      end
    end
    items = []
    new.each do |n|
      items << n[0]
    end
    size = items.size
    case size
    when 1
      rooms = Room.find(:all,:conditions => ["room_floor = ? AND #{items[0]} = ?",floor,true])
    when 2
      rooms = Room.find(:all,:conditions => ["room_floor = ? AND #{items[0]} = ? AND #{items[1]} = ?",floor,true,true])
    when 3
      rooms = Room.find(:all,:conditions => ["room_floor = ? AND #{items[0]} = ? AND #{items[1]} = ? AND #{items[2]} = ?",floor,true,true,true])
    when 4
      rooms = Room.find(:all,:conditions => ["room_floor = ? AND #{items[0]} = ? AND #{items[1]} = ? AND #{items[2]} = ? AND #{items[3]} = ?",floor,true,true,true,true])
    when 5
      rooms = Room.find(:all,:conditions => ["room_floor = ? AND #{items[0]} = ? AND #{items[1]} = ? AND #{items[2]} = ? AND #{items[3]} = ? AND #{items[4]} = ?",floor,true,true,true,true,true])
    when 6
      rooms = Room.find(:all,:conditions => ["room_floor = ? AND #{items[0]} = ? AND #{items[1]} = ? AND #{items[2]} = ? AND #{items[3]} = ? AND #{items[4]} = ? AND #{items[5]} = ?",floor,true,true,true,true,true,true])
    when 7
      rooms = Room.find(:all,:conditions => ["room_floor = ? AND #{items[0]} = ? AND #{items[1]} = ? AND #{items[2]} = ? AND #{items[3]} = ? AND #{items[4]} = ? AND #{items[5]} = ? AND #{items[6]} = ?",floor,true,true,true,true,true,true,true])
    when 8
      rooms = Room.find(:all,:conditions => ["room_floor = ? AND #{items[0]} = ? AND #{items[1]} = ? AND #{items[2]} = ? AND #{items[3]} = ? AND #{items[4]} = ? AND #{items[5]} = ? AND #{items[6]} = ? AND #{items[7]} = ?",floor,true,true,true,true,true,true,true,true])
    else
      rooms = Room.find(:all,:conditions => ["room_floor = ?",floor])
    end
#    t = ERB::Util.h(params[:room_floor])
#    result = nil
#    ["tv","xx"].each do |item|
#      if params[item.to_sym]
#        result = Room.call("have_#{item}")
#      end
#    end
#    result= Room.have_tv.have_tel.xxxx
#    t = "room_floor"
#    d = "tv"
#    rooms = Room.find(:all,:conditions => ["#{t} = ? AND #{d} = ?",floor,true])
    #rooms = Room.find(:all,:conditions => ["room_floor = ? AND projector = ? AND whiteboard = ? AND pc = ? AND webcam = ? AND tel = ? AND tv = ? AND air_condition = ? AND sound_proofing = ?",floor,trans(select['projector']) , trans(select['whiteboard']) , trans(select['pc']) , trans(select['webcam']) , trans(select['tel']) , trans(select['tv']) , trans(select['air_condition']) , trans(select['sound_proofing'])],:order => "room_name ASC")
    #rooms = Room.find(:all,:conditions => ["room_floor = ? AND projector = ? AND whiteboard = ? AND pc = ?",floor,trans(select['projector']),trans(select['whiteboard']),trans(select['pc'])],:order => "room_name ASC")
    if rooms
      rooms.each do |r|
      room << r.room_name
      end
    end

    params["room"] = room
    return params
  end
  #************
  def trans(param)
    if param == "1"
      return true
    else
      return false
    end
  end
end
