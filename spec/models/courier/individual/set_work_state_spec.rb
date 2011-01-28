require 'spec_helper'

describe Courier::Individual do 
  describe 'Create set work_state to available' do
    context 'The current courier from Munich' do
      before do
        @current_courier = Courier::Individual.create_from :munich
      end

      it "should be valid and should be able to save it" do    
        @current_courier.work_state = "available"
        if !@current_courier.valid?
          p "errors: #{@current_courier.errors}"
        end
        
        lambda {@current_courier.save!}.should_not raise_error
        
        @current_courier.work_state.should == "available"
      end
    end
  end
end

