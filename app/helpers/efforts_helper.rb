module EffortsHelper
  def hh_mm(start, stop)
    stop ||= Time.now
    #stop-start
    hh = ((stop - start) / 3600).to_i
    mm = (hh + 1) * 60 - ((stop - start) / 60).to_i
    if hh > 0
      hh.to_s + 'h ' + mm.to_s + 'm'
    else
      mm.to_s + 'm'
    end
  end
end
