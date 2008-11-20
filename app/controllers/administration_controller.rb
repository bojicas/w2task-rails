class AdministrationController < ApplicationController
  def index
    @businesses = Business.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @businesses }
    end
  end
end
