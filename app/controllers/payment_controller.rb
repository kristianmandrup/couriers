class PaymentController < InheritedResources::Base
  before_filter :authenticate_user!

  # show form to enter payment
  def new    
  end

  # create a new payment
  def create
  end
end
