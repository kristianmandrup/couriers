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
    def first_names city = :munich
      {
        :munich     => ['Michael', 'Florian', 'Martin', 'Mathias', 'Julia', 'Lena'],
        :vancouver  => ['Mike', 'David', 'John', 'Sandy', 'Rick', 'Tracy'],
      }
    end 

    def last_names city = :munich
      {
        :munich     => ['Loehr', 'Walz', 'Blau', 'Schwarz'],
        :vancouver  => ['Jackson', 'Smith', 'Johnson', 'Meeker', 'Donovan', 'Gray'],
      }
    end 

    def create_from city = :munich
      city ||= :munich
      Person::Name.new :first_name => first_names[city.to_sym].pick_one , :last_name => last_names[city.to_sym].pick_one
    end
  end
    
  protected
  
  def strip_names
    self.first_name.strip!
    self.last_name.strip!
  end  
end