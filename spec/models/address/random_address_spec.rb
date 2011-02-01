require 'spec_helper'

describe Address do
  describe 'Random Address creation' do
    it 'should not create a valid address' do
      adr = Address.create_for
      if !adr.valid?
        p "adr: #{adr.inspect}"
        p "errors: #{adr.errors}"
      else
        adr.should be_valid
        p adr
      end
    end

    it 'should create some valid addresses from munich' do
      3.times do
        adr = Address.create_from :munich
        adr.should be_valid
        if !adr.valid?
          p "adr: #{adr.inspect}"
          p "errors: #{adr.errors}"
        else
          adr.should be_valid
        end
      end
    end
  end
end
