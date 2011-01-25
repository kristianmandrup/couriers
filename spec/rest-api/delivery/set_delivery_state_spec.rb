require 'spec_helper'

describe 'Delivery state api' do  
  let(:service) { "#{host}/couriers/:id/current_delivery/state" }
  # Set the state of a specific delivery
  # 
  # courier/deliveries/1/state :put
  # {
  #   state: "ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed",
  #   location: {
  #           longitude: "-34.397", 
  #           latitude: "150.644"
  #         }
  # }    

  # {
  #   rolf:     {id: 4, state: 'accepted' },
  #   lena:     {id: 5, state: 'declined' },
  #   silke:    {id: 6, state: 'canceled' },
  #   patricia: {id: 7, state: 'arrived_at_pickup' },
  #   michael:  {id: 8, state: 'arrived_at_dropoff' },
  #   chris:    {id: 9, state: 'billed' },
  # }


  # REQUEST
  # {
  #   state: "accepted",
  #   location: {
  #           longitude: "-34.397", 
  #           latitude: "150.644"
  #         }
  # }    

  # RESPONSE
  # {
  #     status: {
  #         code: "OK",
  #         message: "Delivery accepted"
  #     }
  # }  
  describe 'Set delivery state' do
    context 'Courier ACCEPTS delivery' do
      before :each do
      end

      #   rolf:     {id: 4, state: 'accepted' }
      it 'should set the state of a specific delivery' do
        response = RestClient.put(*delivery_args(:rolf))
        response.status.code.should == 'OK'
        response.status.message.should == 'Delivery accepted'        
      end
    end # context - accept


    # REQUEST
    # {
    #   state: "declined",
    #   location: {
    #           longitude: "-34.397", 
    #           latitude: "150.644"
    #         }
    # }    

    # RESPONSE
    # {
    #     status: {
    #         code: "OK",
    #         message: "Delivery declined"
    #     }
    # }  
    context 'Courier DECLINES delivery' do
      before :each do
      end

      #   lena:     {id: 5, state: 'declined' },
      it 'should cancel the specific delivery' do
        response = RestClient.put(*delivery_args(:lena))
        response.status.code.should == 'OK'
        response.status.message.should == 'Delivery declined'
      end
    end # context - decline

    # REQUEST
    # {
    #   state: "cancelled",
    #   location: {
    #           longitude: "-34.397", 
    #           latitude: "150.644"
    #         }
    # }    

    # RESPONSE
    # {
    #     status: {
    #         code: "OK",
    #         message: "Delivery accepted"
    #     }
    # }  
    context 'Courier CANCELS delivery' do
      before :each do
      end

      #   silke:    {id: 6, state: 'canceled' }
      it 'should cancel the specific delivery' do
        response = RestClient.put(*delivery_args(:silke))
        response.status.code.should == 'OK'
        response.status.message.should == 'Delivery cancelled'
      end
    end # context - cancel


    # REQUEST
    # {
    #   state: "arrived_at_pickup",
    #   location: {
    #           longitude: "-34.397", 
    #           latitude: "150.644"
    #         }
    # }    

    # RESPONSE
    # {
    #     status: {
    #         code: "OK",
    #         message: "Courier arrived at pickup"
    #     }
    # }  
    context 'Courier ARRIVED AT PICKUP for delivery' do
      before :each do
      end

      #   patricia: {id: 7, state: 'arrived_at_pickup' },
      it 'should set the state of a specific delivery' do
        response = RestClient.put(*delivery_args(:patricia))
        response.status.code.should == 'OK'
        response.status.message.should == 'Courier arrived at pickup'
      end
    end # context - arrived_at_pickup

    # REQUEST
    # {
    #   state: "arrived_at_dropoff",
    #   location: {
    #           longitude: -34.397, 
    #           latitude: 150.644
    #         }
    # }    

    # RESPONSE
    # {
    #     status: {
    #         code: "OK",
    #         message: "Courier arrived at dropoff"
    #     }
    # }        
    context 'Courier ARRIVED AT DROPOFF delivery' do
      before :each do
      end

      # michael:  {id: 8, state: 'arrived_at_dropoff' },
      it 'should set the state of a specific delivery' do
        response = RestClient.put(*delivery_args(:michael))
        response.status.code.should == 'OK'
        response.status.message.should == 'Courier arrived at dropoff'
      end
    end # context - accept

    # REQUEST
    # {
    #   state: "billed",
    #   location: {
    #           longitude: "-34.397", 
    #           latitude: "150.644"
    #         }
    # }    

    # RESPONSE
    # {
    #     status: {
    #         code: "OK",
    #         message: "Courier billed delivery"
    #     }
    # }        

    context 'Courier BILLED delivery' do
      before :each do
      end

      #   chris:    {id: 9, state: 'billed' },      
      it 'should set the state of a specific delivery' do
        response = RestClient.put(*delivery_args(:chris))
        response.status.code.should == 'OK'
        response.status.message.should == 'Courier billed delivery'
      end
    end # context - accept
  end # Set delivery state
end
