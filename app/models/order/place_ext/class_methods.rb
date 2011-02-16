class Order
  module PlaceExt
    module ClassMethods    
      include ::OptionExtractor

      def create_from_params params
        place = create_empty
        place.notes   = params[:notes]
        place.address = Address.create_for :street => params[:street] # use geocode
        place.contact = Contact.create_for :channel => params[:contact_info], :name => params[:name]
        place
      end

      def create_for options = {}
        place = create_empty
        place.notes   = extract_notes options
        place.contact = extract_contact options
        place.address = extract_address options
        place
      end
    end
  end
end