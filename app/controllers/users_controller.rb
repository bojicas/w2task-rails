class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  before_filter :login_required, :except => ['new', 'create']
  
  # layout "application", :only => ['edit', 'update']
  # TODO: finalize the layout is
  layout :context_layout
  
  # render new.rhtml
  def new
    @user = User.new
  end

  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    
    if verify_recaptcha(@user)
      success = @user && @user.save 
    else
      success = false
    end
    
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  # GET /users/2/edit
  def edit
    if params[:id].to_i == self.current_user.id
      @user = User.find(params[:id])
    else
      flash[:error] = "Not allowed!"
      redirect_back_or_default('/')
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(:action => 'edit') }
        format.xml  { head :ok }
      else
        flash[:error] = 'User was not successfully updated.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  private

  def context_layout
    logged_in? ? "application" : "login"
  end
end
