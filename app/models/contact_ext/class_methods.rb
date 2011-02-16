module ContactExt
  module ClassMethods
    include ::OptionExtractor    

    def create_empty
      contact           = Contact.new
      contact.name      = Person::Name.create_empty
      contact.channel   = Contact::Channel.create_empty
      contact      
    end

    def create_for options = {}
      contact           = Contact.new
      contact.name      = extract_person_name options
      contact.channel   = extract_channel options
      contact      
    end

    def create_from city = :munich
      contact = Contact.new
      contact.name     = Person::Name.create_from city
      contact.channel  = Contact::Channel.create_from city
      contact      
    end
  end    
end