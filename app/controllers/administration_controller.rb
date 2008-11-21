class AdministrationController < ApplicationController
  def index
    @businesses = Business.find(:all,
      :joins => [:user_associations => :user],
      :conditions => ["users.id = ?", session[:user_id]]
    )
  
    # @user = User.find(:all, :conditions => ["id = ?", session[:user_id]])
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @businesses }
    end
  end

end
