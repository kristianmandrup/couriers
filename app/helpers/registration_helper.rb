module RegistrationHelper

  USERS = {
    :individual_courier     => :company,
    :courier_company        => :company,  
    :private_customer       => :person,
    :professional_customer  => :person
  }
  
  def resource_registration_form
    data_template = USERS[resource.class.to_s.underscore]
    render :partial => "registration/#{data_template}"
  end
end
