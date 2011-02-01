class Courier::Counter
  include Mongoid::Document
  
  field :number, :type => Integer
  field :individual_number, :type => Integer
  field :company_number, :type => Integer

  def self.instance
    if !Courier::Counter.first
      Courier::Counter.create :number => 0, :individual_number => 0, :company_number => 0
    end
    @instance ||= Courier::Counter.first
  end

  def self.reset_numbers
    instance.number = 0
    instance.courier_number = 0
    instance.company_number = 0
    instance.save
    instance    
  end

  module Individual
    def self.next
      Courier::Counter.inc_individual
    end
  end

  module Company
    def self.next
      Courier::Counter.inc_company
    end
  end

  def self.current_number
    instance.number
  end
  
  def self.increment
    instance.inc(:number, 1)
    instance.save
    instance.number
  end
  
  def self.inc_individual
    instance.inc(:number, 1)
    instance.inc(:individual_number, 1)
    instance.save
    instance.individual_number
  end

  def self.inc_company
    instance.inc(:number, 1)
    instance.inc(:company_number, 1)
    instance.save
    instance.company_number    
  end
end