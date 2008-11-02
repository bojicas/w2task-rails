class Effort < ActiveRecord::Base
  def minutes(start, stop)
    stop ||= Time.now
    ((stop - start) / 60).to_i
  end
  
end
