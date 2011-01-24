class RegistrationMailer < ActionMailer::Base  
  default :from => 'no-reply@tiramizoo.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.welcome.subject
  #
  def registration_confirmed(user)
    @greeting = "Hi"
    mail :to => user.email, :subject => 'Registration confirmed' do |format|
      format.text
      format.html
    end
  end

  def registration_denied(user)
    mail :to => user.email, :subject => 'Registration denied'do |format|
      format.text
      format.html
    end
  end
end
