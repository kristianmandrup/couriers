module UsersHelper
  def self.type 
    {
      :individual_courier     => :company,
      :courier_company        => :company,  
      :private_customer       => :person,
      :professional_customer  => :person
    }
  end
  
  def render_user_inputs
    render :partial => 'address/form'  if resource.has_address?
    render :partial => 'profiles/form' if resource.has_profile?

    render_bank_account_inputs if resource.has_bankaccount?
    render_vehicle_inputs if resource.has_vehicles?
  end

  def render_bank_account_inputs
    render :partial => 'bank_account/form'  
  end
  
  def render_vehicle_inputs
    render :partial => 'vehicles/individual_form' if resource.is_person?
    render :partial => 'vehicles/company_form' if resource.is_company?
  end
  
end
