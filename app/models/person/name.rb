require 'person/name_ext/class_methods'

class Person
  class Name
    include Mongoid::Document

    field :first_name, :type => String
    field :last_name, :type => String  

    embedded_in :person, :inverse_of => :name

    validates_with FullNameValidator  
    before_validation :strip_names

    extend  Person::NameExt::ClassMethods
    include Person::NameExt::Api

    def full_name
      [first_name, last_name].join(' ')
    end

    def to_s
      full_name
    end
    
    protected
  
    def strip_names
      strip_it! self.first_name
      strip_it! self.last_name
    end  
  
    def strip_it! field
      field.strip! if !field.blank?    
    end    
  end
end