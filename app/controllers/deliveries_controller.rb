class DeliveriesController < ApplicationController 
  # List deliveries
  def index
    @deliveries = current_courier.deliveries
    respond_with(@deliveries)
  end
end