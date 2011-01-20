class Courier::Counter
  include Mongoid::Document
  
  field :number, :type => Integer
  field :courier_number, :type => Integer
  field :company_number, :type => Integer

  def self.instance
    if !Courier::Counter.first
      Courier::Counter.create :number => 1, :courier_number => 1, :company_number => 1
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

  def self.current_number
    instance.number
  end
  
  def self.increment
    instance.inc(:number, 1)
    p "number: #{instance.number}"
    instance.save
    instance.number
  end
  
  def self.inc_courier
    instance.inc(:number, 1)
    instance.inc(:courier_number, 1)
    instance.save
    instance.courier_number    
  end

  def self.inc_company
    instance.inc(:number, 1)
    instance.inc(:company_number, 1)
    instance.save
    instance.company_number    
  end
end