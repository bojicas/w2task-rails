class Business < ActiveRecord::Base
  
  belongs_to :country
  has_many :users, :through => :user_associations
  has_many :user_associations, :dependent => :destroy
  has_many :efforts
  has_many :projects
  
  validates_presence_of :nick, :name, :country_id
  validates_numericality_of :country_id
  validates_uniqueness_of :nick
  validates_exclusion_of :nick, :in => %w( blog mail support admin smtp imap pop webmail www otms )
  
  # couldn't find yet the reason to use named_scope
  # i can get same functionality via find_by_nick(current_subdomain)
  # named_scope :current_business, lambda { |current_subdomain| { :conditions => { :businesses => { :nick => current_subdomain } } } }
  


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
