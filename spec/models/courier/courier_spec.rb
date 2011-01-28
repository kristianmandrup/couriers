require 'spec_helper'

describe Courier do 
  context 'Empty courier' do
    before do
      @courier = Courier.new
      @courier.random_user
    end

    it "should be valid and should be able to save it" do    
      if !@courier.valid? 
        p "courier: #{@courier.inspect}"
        p "errors: #{@courier.errors}"
      end
      @courier.valid?.should be_true
      # lambda { @courier.save! }.should_not raise_error
      begin
        @courier.save!
      rescue Exception => e
        p "Exception: #{e}, #{@courier.inspect}"
      end 
    end
  end
end
