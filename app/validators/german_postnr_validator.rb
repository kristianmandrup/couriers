class GermanPostnrValidator < ActiveModel::EachValidator

  # ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed
  def valid_states
    Courier.work_states
  end

  def validate_each(record, attribute, value)
    begin
      return if value.blank?
      too_short if value.size < 6
      too_long if value.size > 6
    rescue
    end
    record.errors[attribute] << "is not a valid work state, was #{value.inspect}" unless result
  end    
  
  def too_short
    record.errors[attribute] << "is too short"
  end

  def too_long
    record.errors[attribute] << "is too long"
  end
end

