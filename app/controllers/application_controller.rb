# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  # session :session_key => '_w2task_session_id' 
  
  before_filter :login_required
  before_filter :set_user_time_zone
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery :secret => 'd84522da647e8497fc72462a9dd3e59d'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  private
  
  def set_user_time_zone
    Time.zone = current_user.time_zone if logged_in?
  end
  
  helper_method :current_business
  def current_business
    # this is useful, when coming back from support center, or development log
    # the user is redirected back to his business
    if session[:business_id] && !current_subdomain
      business_nick = current_user.businesses.find(session[:business_id].to_i).nick
      if business_nick
        redirect_to efforts_path(:subdomain => business_nick)
        return
      end
    end
    
    # if the user is asigned to only one business, then redirect to it
    if !current_subdomain
      business_nicks = current_user.businesses.find(:all)
      if business_nicks.size == 1
        redirect_to efforts_path(:subdomain => business_nicks[0].nick)
        return
      end
    end
    
    # at this point I must be already redirected. the only other choice
    # is that the user is not associated with any other businesses
    @business = current_user.businesses.find_by_nick(current_subdomain)
      
    if @business.nil?
      flash[:error] = "You should select/create a business!"
      session[:business_id] = nil
      redirect_to :controller => :administration, :action => :index
    else
      session[:business_id] = @business.id
    end
    
    @business
  end
end
