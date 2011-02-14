require 'spec_helper'

describe Location do
  describe 'Move it' do
    describe '#create' do
      it 'should move location' do
        loc = Location.create :longitude => 11.23, :latitude => 48.3
        loc.move 0.002, 0.00032
        puts loc
      end
    end

    describe '#create_from' do    
      it 'should create it' do      
        loc = Location.create_from :munich
        puts loc
      end
    end

    describe '#create_from_location' do    
      it 'should create it' do      
        loc = Location.create_from_location :longitude => 11.23, :latitude => 48.3
        puts loc
      end
    end

    describe '#create_from_city' do    
      it 'should create it' do      
        loc = Location.create_from_city :munich
        puts loc
      end
    end
  end
end