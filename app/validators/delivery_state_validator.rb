class DeliveryStateValidator < ActiveModel::EachValidator

  # ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed
  def delivery_states
    Order::Delivery.delivery_states
  end

  def validate_each(record, attribute, value)
    result = delivery_states.include? value.to_s.to_sym    
    record.errors[attribute] << "is not a valid delivery state" unless result
  end
end

