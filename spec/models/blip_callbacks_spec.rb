require 'spec_helper'

describe Blip do 
  it "Should create random individual courier" do
    blip = Blip.new
    p blip.inspect
  end
end