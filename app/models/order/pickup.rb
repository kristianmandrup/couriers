class Order::Pickup < Order::Place
  include Mongoid::Document
  
  embedded_in :booking, :inverse_of => :pickup

  # def self.create_from_params params
  #   place = create_empty
  #   place.notes   = params[:notes]
  #   place.address = Address.create_for :street => params[:street] # use geocode
  #   place.contact = Contact.create_for :channel => params[:contact_info], :name => params[:name]
  #   place
  # end
  # 
  # def self.create_empty
  #   place = self.new
  #   place.address  = Address.create_empty
  #   place.contact  = Contact.create_empty
  #   place
  # end
  
end