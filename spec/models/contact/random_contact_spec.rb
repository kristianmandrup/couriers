require 'spec_helper'

describe Contact do 
  it "should create random contact" do
    contact = Contact.create_for
    puts contact.inspect
    puts contact.channel.inspect
    puts contact.name.inspect
    contact.full_name.should_not be_blank
  end
end
