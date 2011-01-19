require 'spec_helper'

describe Location do
  describe 'Move it' do
    it 'should move location' do
      loc = Location.create :longitude => 11.23, :latitude => 48.3
      loc.move 0.002, 0.00032
      puts loc

    end
  end
end