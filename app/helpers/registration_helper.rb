module RegistrationHelper
  
  def resource_registration_form
    data_template = UserHelper.type[resource.class.to_s.underscore]
    render :partial => "registration/#{data_template}"
  end
end
