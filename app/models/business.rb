class Business < ActiveRecord::Base
  
  belongs_to :country
  has_many :users, :through => :user_associations
  has_many :user_associations, :dependent => :destroy
  has_many :efforts
  has_many :projects
  
  validates_presence_of :nick, :name, :country_id
  validates_numericality_of :country_id
  validates_uniqueness_of :nick
 
  def user_association_attributes=(user_association_attributes)
    user_associations.build(user_association_attributes)
  end

  #  This is in case we want more than 1 businessed to assign at once
  #  source: Railscast - episode 73
  #  def user_association_attributes=(user_association_attributes)
  #    user_association_attributes.each do |attributes|
  #      user_associations.build(attributes)
  #    end
  #  end

end
