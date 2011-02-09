class Address::Book
  include Mongoid::Document

  embeds_many :addresses, :class_name => 'Address::Book'  
  embedded_in :customer, :reverse_of => :address_book  
end
