class UsersController < ApplicationController
  layout "backstage"
  # GET /users
  # GET /users.json
  def index
    @user_i = User.find(session[:user_id])
    @users = User.order("b_department,d_department").paginate(:page => params[:page],:per_page => 10 )
    @users.each do |user|
      user[:position_name] = Position.find_by_key(user.position).value unless 
         Position.find_by_key(user.position).nil?
      user[:b_department_name] = BDepartment.find_by_key(user.b_department).value unless 
       BDepartment.find_by_key(user.b_department).nil?
      user[:d_department_name]  = DDepartment.find_by_key(user.d_department).value unless 
       DDepartment.find_by_key(user.d_department).nil?
      user[:user_type_name] = UserType.find_by_key(user.user_type).value unless 
         UserType.find_by_key(user.user_type).nil?
    end
    #@users.paginate(:page => params[:page],:per_page => 10 )
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user_i = User.find(session[:user_id])
    @user = User.find(params[:id])
    @user[:position_name] = Position.find_by_key(@user.position).value unless 
         Position.find_by_key(@user.position).nil?
    @user[:b_department_name] = BDepartment.find_by_key(@user.b_department).value unless 
       BDepartment.find_by_key(@user.b_department).nil?
    @user[:d_department_name]  = DDepartment.find_by_key(@user.d_department).value unless 
       DDepartment.find_by_key(@user.d_department).nil?
    @user[:user_type_name] = UserType.find_by_key(@user.user_type).value unless 
         UserType.find_by_key(@user.user_type).nil?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user_i = User.find(session[:user_id])
    @user = User.new
    @bd_names = BDepartment.all.map {|x| [x.value,x.key]}
    @dd_names = DDepartment.all.map {|x| [x.value,x.key]}
    @ut_names = UserType.all.map {|x| [x.value,x.key]}
    @pt_names = Position.all.map {|x| [x.value,x.key]}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user_i = User.find(session[:user_id])
    @bd_names = BDepartment.all.map {|x| [x.value,x.key]}
    @dd_names = DDepartment.all.map {|x| [x.value,x.key]}
    @ut_names = UserType.all.map {|x| [x.value,x.key]}
    @pt_names = Position.all.map {|x| [x.value,x.key]}

    @user = User.find(params[:id])
    # @user[:position_name] = Position.find_by_key(@user.position).value unless 
    #      Position.find_by_key(@user.position).nil?
    # @user[:b_department_name] = BDepartment.find_by_key(@user.b_department).value unless 
    #    BDepartment.find_by_key(@user.b_department).nil?
    # @user[:d_department_name]  = DDepartment.find_by_key(@user.d_department).value unless 
    #    DDepartment.find_by_key(@user.d_department).nil?
    # @user[:user_type_name] = UserType.find_by_key(@user.user_type).value unless 
    #      UserType.find_by_key(@user.user_type).nil?
  end

  # POST /users
  # POST /users.json
  def create
    @user_i = User.find(session[:user_id])
    user = Hash.new

    user[:position] = params[:position]
    user[:b_department] = params[:b_department]
    user[:d_department] = params[:d_department]
    user[:user_type] = params[:user_type]
    user[:number] = params[:number]
    user[:name] = params[:name]
    user[:email] = params[:email]
    user[:tel] = params[:tel]
    user[:password] = params[:number]
    user[:superuser] = params[:superuser]
    
    @user = User.new(user)

    respond_to do |format|
      if @user.valid?
        @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        flash[:notice] = @user.errors.messages.values.join("\n")
        format.html { redirect_to :action => "new"}
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user_i = User.find(session[:user_id])

    # @user = User.find(params[:id])
    # @user[:position] = Position.find_by_value(params[:positon_name]).key
    # @user[:b_department] = BDepartment.find_by_value(params[:b_department_name]).key
    # @user[:d_department] = DDepartment.find_by_value(params[:d_department_name]).key
    # @user[:user_type] = UserType.find_by_value(params[:user_type_name]).key

    # @user[:position] = params[:position]
    # @user[:b_department] = params[:b_department]
    # @user[:d_department] = params[:d_department]
    # @user[:user_type] = params[:user_type]
    # @user[:number] = params[:number]
    # @user[:name] = params[:name]
    # @user[:email] = params[:email]
    # @user[:tel] = params[:tel]
    # @user[:password] = params[:number]
    # @user[:admin] = params[:admin]

     @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user_i = User.find(session[:user_id])
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
