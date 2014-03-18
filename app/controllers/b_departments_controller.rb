class BDepartmentsController < ApplicationController
  # GET /b_departments
  # GET /b_departments.json
  def index
    @b_departments = BDepartment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @b_departments }
    end
  end

  # GET /b_departments/1
  # GET /b_departments/1.json
  def show
    @b_department = BDepartment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @b_department }
    end
  end

  # GET /b_departments/new
  # GET /b_departments/new.json
  def new
    @b_department = BDepartment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @b_department }
    end
  end

  # GET /b_departments/1/edit
  def edit
    @b_department = BDepartment.find(params[:id])
  end

  # POST /b_departments
  # POST /b_departments.json
  def create
    @b_department = BDepartment.new(params[:b_department])

    respond_to do |format|
      if @b_department.save
        format.html { redirect_to @b_department, notice: 'B department was successfully created.' }
        format.json { render json: @b_department, status: :created, location: @b_department }
      else
        format.html { render action: "new" }
        format.json { render json: @b_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /b_departments/1
  # PUT /b_departments/1.json
  def update
    @b_department = BDepartment.find(params[:id])

    respond_to do |format|
      if @b_department.update_attributes(params[:b_department])
        format.html { redirect_to @b_department, notice: 'B department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @b_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /b_departments/1
  # DELETE /b_departments/1.json
  def destroy
    @b_department = BDepartment.find(params[:id])
    @b_department.destroy

    respond_to do |format|
      format.html { redirect_to b_departments_url }
      format.json { head :no_content }
    end
  end
end
