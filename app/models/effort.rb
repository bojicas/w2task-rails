class Effort < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :business
  
  validates_presence_of :business_id, :user_id
  validates_numericality_of :business_id, :user_id
  
end
