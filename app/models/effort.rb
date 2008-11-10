class Effort < ActiveRecord::Base
  
  belongs_to :user
  
  def minutes(start, stop)
    stop ||= Time.now
    ((stop - start) / 60).to_i
  end
  
end
