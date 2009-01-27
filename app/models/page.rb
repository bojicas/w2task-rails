class Page < ActiveRecord::Base
  validates_uniqueness_of :slug
  validates_presence_of :slug, :title, :body
  
  def to_param
    slug
  end
end
