class EffortsController < ApplicationController
  # GET /efforts
  # GET /efforts.xml
  def index
    @page_title = "Listing efforts"
    
    session[:user_login] = User.find_by_id(session[:user_id]).login
    #session[:business_id] ||= UserAssociation.find_by_user_id(session[:user_id]).business_id
    
    @efforts = Effort.paginate(:all, 
      :order => "start DESC, stop DESC, body", 
      :page => params[:page],
      :per_page => 10 )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @efforts }
    end
  end

  # GET /efforts/1
  # GET /efforts/1.xml
  def show
    @effort = Effort.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @effort }
    end
  end

  # GET /efforts/new
  # GET /efforts/new.xml
  def new
    @effort = Effort.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @effort }
    end
  end

  # GET /efforts/1/edit
  def edit
    @effort = Effort.find(params[:id])
  end

  # POST /efforts
  # POST /efforts.xml
  def create
    @effort = Effort.new(params[:effort])

    respond_to do |format|
      if @effort.save
        flash[:notice] = 'Effort was successfully created.'
        format.html { redirect_to(efforts_url) }
        format.xml  { render :xml => @effort, :status => :created, :location => @effort }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @effort.errors, :status => :unprocessable_entity }
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
        format.html { redirect_to(efforts_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @effort.errors, :status => :unprocessable_entity }
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
end
