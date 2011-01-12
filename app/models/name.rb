class Name
  include Mongoid::Document

  field :first_name, :type => String
  field :last_name, :type => String  

  def full_name
    [first_name, last_name].join(' ')
  end
  
  validates_with FullNameValidator  
  before_validation :strip_names
  
  private
  
  def strip_names
    self.first_name.strip!
    self.last_name.strip!
  end  
end