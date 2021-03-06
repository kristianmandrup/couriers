class TimePeriod
  include Mongoid::Document
  
  field :from,        :type => Time
  field :to,          :type => Time

  referenced_in :courier, :inverse_of => :working_hours
  
  def self.to_s time_period
    out_str = ''
    interval_array = [ [:weeks, 604800], [:days, 86400], [:hours, 3600], [:mins, 60] ]
    interval_array.each do |sub|
      if time_period>= sub[1] then
        time_val, time_period = time_period.divmod( sub[1] )
        time_val == 1 ? name = sub[0].to_s.singularize : name = sub[0].to_s
        ( sub[0] != :mins ? out_str += ", " : out_str += " and " ) if out_str != ''
        out_str += time_val.to_s + " #{name}"
      end
    end
    return out_str 
  end  
end
