class Company
  include Mongoid::Document

  field       :name, :type => String
  
  embeds_one  :address
  embeds_one  :contact
  embeds_one  :profile

  embeds_one  :channel, :class_name => 'Contact::Channel'

  module Api
    def for_json
      {:name => name, :address => address.for_json, :contact => contact.for_json }
    end
  end
  include Api

  validates :name, :presence => true, :length => {:within => 2..40}, :company_name => true  

  after_initialize :strip_name

  def full_name
    contact.full_name
  end

  def full_name= full_name
    contact.full_name = full_name
  end

  class << self
    include ::OptionExtractor

    def names
      ['messenger', 'twister', 'courier AG']
    end
    
    def create_for options = {}
      company = Company.new 
      company.name    = names.pick_one
      company.contact = extract_contact options
      company.address = extract_address options
      company
    end
  end
    
  protected 
  
  def strip_name
    self.name = self.name.strip if self.name && !self.name.blank?
  end
end
