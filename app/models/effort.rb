class Effort < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :business
  belongs_to :project
  
  validates_presence_of :business_id, :user_id, :body
  validates_numericality_of :business_id, :user_id
  
  def find_all_projects(user_id, business_id)
    Project.find(:all, :conditions => { :business_id => business_id }).collect {|u| ["#{u.name}", u.id]}
  end
end
