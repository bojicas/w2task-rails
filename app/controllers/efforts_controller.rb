class EffortsController < ApplicationController
  # GET /efforts
  # GET /efforts.xml
  def index
    @efforts_today = Effort.find(:all, :order => "start DESC, stop DESC, body", :conditions => "start >= '#{Time.today.to_s(:db)}'")
    @efforts_yestarday = Effort.find(:all, :order => "start DESC, stop DESC, body", :conditions => { :start => (1.day.ago(Time.today))...(Time.today-1) })

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
        format.html { redirect_to(@effort) }
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
        format.html { redirect_to(@effort) }
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
