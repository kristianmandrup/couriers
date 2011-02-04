module BookingsHelper
  def current_booking
    session[:booking]
  end
end