class OrderStateValidator < ActiveModel::EachValidator

  # ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed
  def validate_each(record, attribute, value)
    result = Order.valid_state? value
    record.errors[attribute] << "is not a valid order state" unless result
  end
end

