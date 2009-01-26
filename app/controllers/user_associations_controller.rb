class UserAssociationsController < ApplicationController
  # GET /user_associations
  # GET /user_associations.xml
  def index
    @page_title = "Administration"
    
    @businesses = Business.find(:all,
      :joins => [ :user_associations => :user ],
      :conditions => { "users.id" => session[:user_id] }
    )
   
    @users = User.find(:all,
      :joins => [ :user_associations => :business ],
      :conditions => { "businesses.nick" => current_subdomain }
    )
    
    @user_associations = UserAssociation.find(:all,
      :conditions => { :business_id => session[:business_id] }
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_associations }
    end
  end

  # GET /user_associations/1
  # GET /user_associations/1.xml
  def show
    @user_association = UserAssociation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_association }
    end
  end

  # GET /user_associations/new
  # GET /user_associations/new.xml
  def new
    @user_association = UserAssociation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_association }
    end
  end

  # GET /user_associations/1/edit
  def edit
    @user_association = UserAssociation.find(params[:id])
  end

  # POST /user_associations
  # POST /user_associations.xml
  def create
    @user_association = UserAssociation.new(params[:user_association])

    respond_to do |format|
      if @user_association.save
        flash[:notice] = 'UserAssociation was successfully created.'
        format.html { redirect_to(@user_association) }
        format.xml  { render :xml => @user_association, :status => :created, :location => @user_association }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_associations/1
  # PUT /user_associations/1.xml
  def update
    @user_association = UserAssociation.find(params[:id])

    respond_to do |format|
      if @user_association.update_attributes(params[:user_association])
        flash[:notice] = 'UserAssociation was successfully updated.'
        format.html { redirect_to(@user_association) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_associations/1
  # DELETE /user_associations/1.xml
  def destroy
    @user_association = UserAssociation.find(params[:id])
    @user_association.destroy

    respond_to do |format|
      format.html { redirect_to(user_associations_url) }
      format.xml  { head :ok }
    end
  end
end
