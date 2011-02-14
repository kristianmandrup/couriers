require 'courier/company/class_methods'
# require 'courier/company/api'
# require 'courier/company/proxies'

class Courier
  class Company < ::Courier
    include Mongoid::Document

    field       :company_number,  :type => Integer  
    embeds_one  :company,         :class_name => 'Company'

    references_and_referenced_in_many :employees, :class_name => 'Courier'

    # after_initialize :set_number

    extend ClassMethods
    # include Api
    # include Proxies

    def type
      'company'
    end

    def delivery= delivery
      self.order = delivery
    end

    def delivery
      self.order
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

    protected

    def set_number    
      self.company_number = Courier::Counter.inc_company
      super
      save    
    end  
  end
end