class CouriersController < ActionController::Base
  before_filter :authenticate_user!
  
  def select
    p "select couriers!"
    p params
  end
end