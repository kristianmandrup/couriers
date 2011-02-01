class CouriersController < ActionController::Base
  # before_filter :authenticate_user!
  
  def select
    p "companies selected: #{companies_selected}"
    p "individual couriers selected: #{individuals_selected}"    
  end
end