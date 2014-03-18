class DDepartmentsController < ApplicationController
  # GET /d_departments
  # GET /d_departments.json
  def index
    @d_departments = DDepartment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_departments }
    end
  end

  # GET /d_departments/1
  # GET /d_departments/1.json
  def show
    @d_department = DDepartment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_department }
    end
  end

  # GET /d_departments/new
  # GET /d_departments/new.json
  def new
    @d_department = DDepartment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_department }
    end
  end

  # GET /d_departments/1/edit
  def edit
    @d_department = DDepartment.find(params[:id])
  end

  # POST /d_departments
  # POST /d_departments.json
  def create
    @d_department = DDepartment.new(params[:d_department])

    respond_to do |format|
      if @d_department.save
        format.html { redirect_to @d_department, notice: 'D department was successfully created.' }
        format.json { render json: @d_department, status: :created, location: @d_department }
      else
        format.html { render action: "new" }
        format.json { render json: @d_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_departments/1
  # PUT /d_departments/1.json
  def update
    @d_department = DDepartment.find(params[:id])

    respond_to do |format|
      if @d_department.update_attributes(params[:d_department])
        format.html { redirect_to @d_department, notice: 'D department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_departments/1
  # DELETE /d_departments/1.json
  def destroy
    @d_department = DDepartment.find(params[:id])
    @d_department.destroy

    respond_to do |format|
      format.html { redirect_to d_departments_url }
      format.json { head :no_content }
    end
  end
end
