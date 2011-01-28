class Courier::Company < Courier
  include Mongoid::Document

  field :company_number, :type => Integer
  
  embeds_one :company, :class_name => 'Company'

  def address
    company.address
  end

  def location
    address.location
  end

  def location= loc
    address.location = loc
  end
  
  def type
    'company'
  end

  def name
    company.name
  end

  def available?
    true
  end

  def for_json
    {:email => email, :company => company.for_json}.merge super
  end

  def set_number    
    self.company_number = Courier::Counter.inc_company
    super
    save    
  end

  class << self
    include ::AddressHelper
    
    def create_from options = {}
      city = extract_city options
      co = Courier::Company.new
      co.random_user
      co.company = ::Company.create_from city
      co
    end
  end
end
