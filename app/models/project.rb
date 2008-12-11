class Project < ActiveRecord::Base
  has_many :efforts
  belongs_to :business
  belongs_to :user
end
