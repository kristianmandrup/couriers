class OrdersController < ApplicationController 
  # List deliveries
  def index
    @orders = current_courier.orders
    respond_with(@orders)
  end    
end