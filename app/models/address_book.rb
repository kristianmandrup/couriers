class AddressBook
  include Mongoid::Document

  def self.get_contact_details address
    # AddressBook.addresses.find :street => address.street ...
  end

  embeds_one :address
  embeds_one :contact_info
  embeds_one :person_name
end
