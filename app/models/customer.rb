class Customer < User
  include Mongoid::Document

  # embeds_one :address_book, :class_name => 'Address::Book'
end