require 'company_ext/class_methods'
require 'company_ext/api'

class Company
  include Mongoid::Document

  field       :name, :type => String
  
  embeds_one  :address
  embeds_one  :contact
  embeds_one  :profile

  embeds_one  :channel, :class_name => 'Contact::Channel'

  validates :name, :presence => true, :length => {:within => 2..40}, :company_name => true  

  after_initialize :strip_name

  # PROXIES
  add_proxy_factory :contact => [Contact, :create_empty] 
  proxy_accessors_for :contact, :full_name

  extend CompanyExt::ClassMethods
  include CompanyExt::Api
    
  protected 
  
  def strip_name
    self.name = self.name.strip if self.name && !self.name.blank?
  end
end
