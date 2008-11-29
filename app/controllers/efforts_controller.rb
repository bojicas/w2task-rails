class EffortsController < ApplicationController

  before_filter :load_business_and_assign_to_user

  # GET /efforts
  # GET /efforts.xml
  def index

    @page_title = "Listing efforts"
    session[:page] = 1 unless params[:page]
    
    @efforts = get_efforts
    @effort = Effort.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @efforts }
    end
  end

  # GET /efforts/1
  # GET /efforts/1.xml
  def show
    @effort = Effort.find(params[:id])
    @efforts = get_efforts
    session[:page] = params[:page]

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @effort }
    end
  end

  # GET /efforts/new
  # GET /efforts/new.xml
  def new    
    @effort = Effort.new
    @efforts = get_efforts
    
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @effort }
    end
  end

  # GET /efforts/1/edit
  def edit
    @effort = Effort.find(params[:id])
    @efforts = get_efforts
    session[:page] = params[:page]
    
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @effort }
    end
  end

  # POST /efforts
  # POST /efforts.xml
  def create
    @effort = Effort.new(params[:effort])
    
    respond_to do |format|
      if @effort.save
        flash[:notice] = 'Effort was successfully created.'
        format.html { redirect_to(efforts_url) }
        @efforts = get_efforts
        format.js
        #format.xml  { render :xml => @effort, :status => :created, :location => @effort }
      else
        flash[:error] = 'Cannot create effort.'
        format.html { render :action => "new" }
        @efforts = get_efforts
        format.js
        #format.xml  { render :xml => @effort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /efforts/1
  # PUT /efforts/1.xml
  def update
    @effort = Effort.find(params[:id])

    respond_to do |format|
      if @effort.update_attributes(params[:effort])
        flash[:notice] = 'Effort was successfully updated.'
        @efforts = get_efforts
        format.js
        format.html { redirect_to(:action => index) }
        #format.xml  { head :ok }
      else
        flash[:notice] = 'Effort was not successfully updated.'
        @efforts = get_efforts
        format.js
        format.html { render :action => "edit" }
        #format.xml  { render :xml => @effort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /efforts/1
  # DELETE /efforts/1.xml
  def destroy
    @effort = Effort.find(params[:id])
    @effort.destroy

    respond_to do |format|
      format.html { redirect_to(efforts_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def get_efforts
    efforts = Effort.paginate(:all, 
      :order => "start DESC, created_at DESC, stop DESC, body", 
      :conditions => ["business_id = ?", @business.id],
      :page => params[:page],
      :per_page => 10 )
    efforts
  end
end
