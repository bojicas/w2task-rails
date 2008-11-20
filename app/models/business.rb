class Business < ActiveRecord::Base
  
  has_many :users, :through => :user_associations
  has_many :user_associations
  
end
