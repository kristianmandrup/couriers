module PersonExt
  module ClassMethods
    include ::OptionExtractor

    def create_empty
      Person.new 
    end

    def create_from city = :munich
      create_for :address => {:city => city}
    end      

    def create_for options
      # city            = extract_city options
      person          = create_empty
      person.name     = extract_person_name options
      person.address  = extract_address options
      person.profile  = extract_profile options
      person
    end
  end
end
