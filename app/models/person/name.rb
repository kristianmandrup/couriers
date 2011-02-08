class Person::Name
  include Mongoid::Document

  field :first_name, :type => String
  field :last_name, :type => String  

  embedded_in :person, :inverse_of => :name

  validates_with FullNameValidator  
  before_validation :strip_names

  def full_name
    [first_name, last_name].join(' ')
  end

  def for_json
    {:first => first_name, :last => last_name}
  end

  def to_s
    full_name
  end

  class << self
    include ::OptionExtractor

    def create_empty
      Person::Name.new 
    end

    def create_for options
      city = extract_city options
      name = create_empty
      name.first_name = extract_first_name options
      name.last_name  = extract_last_name options
      name
    end
  end
    
  protected
  
  def strip_names
    self.first_name.strip!
    self.last_name.strip!
  end  
end