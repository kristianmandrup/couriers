class Order::Place
  module ClassMethods    
    include ::OptionExtractor

    def inherited(base)
      base.extend ClassMethods
    end

    def create_empty
      place = self.new
      place.address  = Address.create_empty
      place.contact  = Contact.create_empty
      place
    end

    def create_from_params params
      place = create_empty
      place.notes   = params[:notes]
      place.address = Address.create_for :street => params[:street] # use geocode
      place.contact = Contact.create_for :channel => params[:contact_info], :name => params[:name]
      place
    end

    def create_for options = {}
      place = self.new
      place.notes   = extract_notes options
      place.contact = extract_contact options
      place.address = extract_address options
      place
    end    
  end    
end