class TravelModeValidator < ActiveModel::EachValidator

  # ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed
  def valid_modes
    Courier::Vehicle.travel_modes
  end

  def validate_each(record, attribute, value)
    result = valid_modes.include? value.to_s.to_sym    
    record.errors[attribute] << "is not a valid travel mode" unless result
  end
end

