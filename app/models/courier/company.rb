class Courier::Company < Courier
  include Mongoid::Document

  field       :company_number,  :type => Integer  
  embeds_one  :company,         :class_name => 'Company'

  module Api
    def for_json
      {:email => email, :company => company.for_json}.merge super
    end
  end
  include Api

  def address
    company.address
  end

  def location
    address.location
  end

  def location= loc
    address.location = loc
  end

  def name
    company.name
  end
  
  def type
    'company'
  end

  def available?
    true
  end

    def to_s
      %Q{
  number: #{company_number}
  type: #{type}
  company: #{company}
  }
    end

  def set_number    
    self.company_number = Courier::Counter.inc_company
    super
    save    
  end

  class << self
    include ::OptionExtractor

    def create_for options = {}   
      courier = Courier::Company.new
      courier.random_user
      courier.company     = Company.create_for options
      courier.delivery    = Delivery.create_for options
      courier.work_state  = extract_work_state options
      courier
    end    
  end
end
