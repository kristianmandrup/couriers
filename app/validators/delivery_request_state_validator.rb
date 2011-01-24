class DeliveryRequestStateValidator < ActiveModel::EachValidator

  # ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed
  def valid_states
    Courier::DeliveryRequestState.valid_states
  end

  def validate_each(record, attribute, value)
    begin
      result = valid_states.include? value.to_sym
    rescue
    end
    record.errors[attribute] << "is not a valid delivery request state" unless result
  end    
end

