class Courier::Individual < Courier
  include Mongoid::Document

  field       :courier_number,  :type => Integer
  field       :company_name,    :type => String

  embeds_one  :person

  # after_initialize :set_number

  extend ClassMethods

  # API methods
  include Api
  include Proxies
    
  def available?
    work_state == 'available'
  end
  
  def type
    'individual'
  end  

  def to_s
    %Q{
number: #{courier_number}
type: #{type}
person: #{person}
}
  end

  protected

  def counter
    Courier::Counter::Individual
  end

  def set_number    
    self.courier_number = counter.next
    super
    save
  end  
end

