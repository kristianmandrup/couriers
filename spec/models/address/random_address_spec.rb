require 'spec_helper'

describe Address do
  describe 'Rando Address creation' do
    it 'should create a valid address' do
      10.times do
        adr = Address.create_from :munich
        if !adr.valid?
          p "adr: #{adr.inspect}"
          p "errors: #{adr.errors}"        
        else
          lambda{ adr.save!}.should_not raise_error
        end
      end
    end
  end
end
