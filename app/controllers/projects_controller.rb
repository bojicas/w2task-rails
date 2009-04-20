class ProjectsController < ApplicationController
  
  before_filter :current_business
    
  # GET /projects
  # GET /projects.xml
  def index
    # limit the scope to the current business
    @projects = Project.find(:all, :conditions => { :business_id => session[:business_id] })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    if params[:from_calendar_date] and params[:to_calendar_date] and params[:from_calendar_date].to_date <= params[:to_calendar_date].to_date
      @from_calendar_date  = params[:from_calendar_date].to_date
      @to_calendar_date    = params[:to_calendar_date].to_date
    else
      @from_calendar_date  = "#{Date::MONTHNAMES[Date.today.month]} 01, #{Date.today.year}".to_date 
      @to_calendar_date    = Date.today
    end
    
    if params[:id].to_i == 0
      @project = Project.new
      @project.id = nil
      @project.name = "Internal Effort"
      @project.description = "This is a list of efforts which are not directly attached to a project."
      @project.user_id = current_user.id
      @project.business_id = session[:business_id]
      
      @efforts = current_user.efforts.find(:all, 
        :conditions => { 
          :project_id => nil, 
          :business_id => session[:business_id]
        }
      )
    else
      @project = current_user.projects.find(params[:id])
      @efforts = current_user.efforts.find(:all, 
        :conditions => {
          :project_id => @project.id,
          :business_id => session[:business_id]
        }
      )
    end

    @total_time_spent_on_efforts = total_time_spent_on_efforts(@efforts)
    @users = User.find(:all,
      :joins => [ :user_associations => :business ],
      :conditions => { "businesses.nick" => current_subdomain }
    )

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
  
  
  private
  
  # find the total time, a user spent on a particular business
  def total_time_spent_on_efforts(efforts)    
    total_time_spent = 0
    for effort in efforts
      if effort.stop
        total_time_spent += (effort.stop - effort.start)
      else
        total_time_spent += (Time.now - effort.start)
      end
    end  
    total_time_spent
  end
end
