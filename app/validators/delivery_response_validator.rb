class DeliveryResponseValidator < ActiveModel::EachValidator

  # ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed
  def valid_states
    Delivery::Response.valid_states
  end

  def validate_each(record, attribute, value)
    result = valid_states.include? value.to_s.to_sym    
    record.errors[attribute] << "is not a valid delivery response" unless result
  end
end

