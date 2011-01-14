class Contact::Channel
  include Mongoid::Document
  
  field :phone, :type => String
  field :email, :type => String

  embedded_in :contact, :inverse_of => :channel
  embedded_in :company, :inverse_of => :channel

  def for_json
    {:phone => phone, :email => email}
  end
  
  class << self
    
    def phones
      {
        :munich => ['125215', '2346436', '343423', '574534523']
      }
    end

    def emails
      {
        :munich => ['blip@mail.de', 'blap.blop@mail.de', 'zander@telekom.de', 'jurgen@flashcom.de']
      }
    end
    
    def create_from city = :munich
      Contact::Info.new :phone => phones[city].pick_one, :email => emails[city].pick_one
    end
  end
end