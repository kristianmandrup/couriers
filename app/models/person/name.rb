class Person::Name
  include Mongoid::Document

  field :first_name, :type => String
  field :last_name, :type => String  

  def full_name
    [first_name, last_name].join(' ')
  end

  class << self
    def first_names
      {
        :munich     => ['Michael', 'Florian', 'Martin', 'Mathias', 'Julia', 'Lena'],
        :vancouver  => ['Mike', 'David', 'John', 'Sandy', 'Rick', 'Tracy'],
      }
    end 

    def last_names
      {
        :munich     => ['Loehr', 'Walz', 'Blau', 'Schwarz'],
        :vancouver  => ['Jackson', 'Smith', 'Johnson', 'Meeker', 'Donovan', 'Gray'],
      }
    end 

    def create_from city
      Name.new :first_name => first_names(city).pick_one , :last_name => last_names(city).pick_one
    end
  end
  
  validates_with FullNameValidator  
  before_validation :strip_names
  
  private
  
  def strip_names
    self.first_name.strip!
    self.last_name.strip!
  end  
end