require 'spec_helper'

describe Order::Waybill do 
  context 'A waybill' do
    before do
      @waybill = Order::Waybill.create_for  
    end

    it "should create a valid waybill" do    
      if !@waybill.valid?
        puts "errors: #{@waybill.errors}"
      end
      @waybill.should be_valid
    end
  end
end


