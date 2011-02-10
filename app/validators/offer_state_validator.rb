class OfferStateValidator < ActiveModel::EachValidator

  # ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed
  def validate_each(record, attribute, value)
    begin
      result = Order::Offer.valid_state? value
    rescue
    end
    record.errors[attribute] << "is not a valid offer state, was #{value.inspect}" unless result
  end    
end

