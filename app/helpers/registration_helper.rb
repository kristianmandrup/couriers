module RegistrationHelper

  # used from devise/registrations
  
  def resource_registration_form
    data_template = UserHelper.type[resource.class.to_s.underscore]
    render :partial => "registrations/#{data_template}"
  end
end
