class Country < ActiveRecord::Base
  
  ## 
  # Find all countries in a special order. 
  def self.find_ordered 
    find :all, :order => 'special DESC, name' 
  end 
  
  ## 
  # Find all countries and return in an Array usable 
  # by the select helper. 
  def self.find_for_select 
    find_ordered.collect { |record| [record.name, record.id] } 
  end 
  #Project.find(:all).map {|u| ["#{u.name}", u.id]}
end
