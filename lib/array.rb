class Array
  def pick_one
    self[rand(self.size)]
  end
  
  def for_json
    self.map(&:for_json)
  end
  
  def into_json
    self.map(&:for_json).to_json
  end  
end        
