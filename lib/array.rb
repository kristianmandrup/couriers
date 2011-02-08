class Array
  def pick_one
    self[rand(self.size)]
  end

  def pick_some
    res = []
    rand(self.size).times do    
      res << self[rand(self.size)]
    end
    res.flat_uniq
  end

  def pick_up_to number
    res = []
    number.times do    
      res << self[rand(self.size)]
    end
    res.flat_uniq
  end
  
  def for_json
    self.map(&:for_json)
  end
  
  def into_json
    self.map(&:for_json).to_json
  end  
end        
