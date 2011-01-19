class Address::Empty < Address
  include Mongoid::Document
  
  # Germany (Europe)
  field :postnr,    :type => String
  
  def zip
    self.postnr
  end

  def zip=
    self.postnr = zip
  end  
end