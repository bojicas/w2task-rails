class AdministrationController < ApplicationController
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
  end
end
