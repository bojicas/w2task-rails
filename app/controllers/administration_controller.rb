class AdministrationController < ApplicationController
  def index
    @page_title = "Administration"
    
    @businesses = current_user.businesses.find(:all)
   
    @users = User.find(:all,
      :joins => [ :user_associations => :business ],
      :conditions => { "businesses.nick" => current_subdomain }
    )
  end
end
