class AdministrationController < ApplicationController
  def index
    @business = Business.find_by_user_id(session[:user_id], :limit => 1)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @businesses }
    end
  end
end
