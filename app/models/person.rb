class Person
  include Mongoid::Document

  # General info
  field :first_name,  :type => String
  field :last_name,   :type => String

  embeds_one :address
  embeds_one :profile

  validates_associated :address

  validates :address, :presence => true

  validates_with FullNameValidator  

  # validates :first_name,  :presence => true, :length => {:within => 2..40},   :person_name => true
  # validates :last_name,   :presence => true, :length => {:within => 2..40},   :person_name => true

  before_validation :strip_names
  
  private
  
  def strip_names
    self.first_name.strip!
    self.last_name.strip!
  end
  
end
