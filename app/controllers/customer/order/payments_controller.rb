class Customer
  class Order
    # :new - new payment form
    # :create store the payment info and execute the payment with the provider!
    # resources :payment,   :only => [:new, :create]  
    class PaymentsController < InheritedResources::Base
      before_filter :authenticate_user!

      # show form to enter payment
      def new    
      end

      # create a new payment
      def create
      end
    end
  end
end