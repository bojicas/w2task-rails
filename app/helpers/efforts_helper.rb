module EffortsHelper
  def hh_mm(start, stop)
    stop ||= Time.now
    #stop-start
    hh = ((stop - start) / 3600).to_i
    mm = ((stop - start) / 60).to_i - hh * 60
    if hh > 0
      hh.to_s + 'h ' + mm.to_s + 'm'
    else
      mm.to_s + 'm'
    end
  end
  
  def effort_in_day(user_id, project_id = nil, year = Date.today.year, month = Date.today.month, day = Date.today.day)
    find_date = Date.new(year, month, day)
    
    if project_id
      efforts = Effort.find(:all,
        :conditions => { :user_id => user_id, 
          :start => find_date..find_date+1,
          :project_id => project_id
        }
      )
    else
      efforts = Effort.find(:all,
        :conditions => { :user_id => user_id, 
          :start => find_date..find_date+1
        }
      )
    end
    efforts.size
  end
end
