class Company
  include Mongoid::Document

  field :name, :type => String
  
  embeds_one :address 

  embeds_one :contact
  embeds_one :profile

  embeds_one :contact_info
  
  validates :name, :presence => true, :length => {:within => 2..40}, :company_name => true
  
  before_validation :strip_names
  
  private 
  
  def strip_names
    self.name = self.name.strip
  end
end
