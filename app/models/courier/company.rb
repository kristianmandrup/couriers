class Courier::Company < Courier
  include Mongoid::Document

  field :company_number, :type => Integer
  
  embeds_one  :company

  def location
    company.address.location
  end
  
  def type
    'company'
  end

  def name
    company.name
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
    def create_from options = {}
      city = options[:from] || :munich      
      co = Courier::Company.new options
      co.random_user      
      co.company = Company.create_from city
      co
    end
  end
end
