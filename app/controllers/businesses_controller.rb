class BusinessesController < ApplicationController
  # GET /businesses
  # GET /businesses.xml
  def index
    redirect_to(:controller => "administration")
  end

  # GET /businesses/1
  # GET /businesses/1.xml
  def show
    # this is the original line, which has been replaced due to
    # security reasons. now the search is bound to current_user
    # @business = Business.find(params[:id])
    @business = current_user.businesses.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @business }
    end
  end

  # GET /businesses/new
  # GET /businesses/new.xml
  def new
    @business = Business.new
    @business.user_associations.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @business }
    end
  end

  # GET /businesses/1/edit
  def edit
    @business = Business.find(params[:id])
    # @business = current_user.businesses.find_by_id(params[:id])
  end

  # POST /businesses
  # POST /businesses.xml
  def create
    @business = Business.new(params[:business])
    @business.user_associations.build(:user_id => current_user.id, :administrator => true)

    respond_to do |format|
      if @business.save
        flash[:notice] = 'Business was successfully created.'
        format.html { redirect_to(@business) }
        format.xml  { render :xml => @business, :status => :created, :location => @business }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @business.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /businesses/1
  # PUT /businesses/1.xml
  def update
    @business = Business.find(params[:id])
    # @business = current_user.businesses.find_by_id(params[:id])

    respond_to do |format|
      if @business.update_attributes(params[:business])
        flash[:notice] = 'Business was successfully updated.'
        format.html { redirect_to(@business) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @business.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.xml
  def destroy
    # this is the original line, which has been replaced due to
    # security reasons. now the search is bound to current_user
    @business = Business.find(params[:id])
    # @business = current_user.businesses.find_by_id(params[:id])
    @business.destroy

    respond_to do |format|
      format.html { redirect_to(businesses_url) }
      format.xml  { head :ok }
    end
  end
end
