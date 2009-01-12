# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  session :session_key => '_w2task_session_id' 
  
  before_filter :login_required
  before_filter :set_user_time_zone
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'd84522da647e8497fc72462a9dd3e59d'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  private
  
  def set_user_time_zone
    Time.zone = current_user.time_zone if logged_in?
  end
  
  def load_business_and_assign_to_user
    @business = Business.find_by_nick(current_subdomain,
      :joins => :user_associations,
      :conditions => 
        { :user_associations => {:user_id => self.current_user.id} })
    
    session[:user_login] = User.find_by_id(self.current_user.id).login
      
    if @business.nil?
      flash[:error] = "You are not autorized to access<br />this business data or<br />business does not exist!"
      session[:business_name] = "No business!"
      session[:business_id] = nil
      redirect_to :controller => :administration, :action => :index
    else
      session[:business_name] = @business.name 
      session[:business_id] = @business.id
    end
  end
end
