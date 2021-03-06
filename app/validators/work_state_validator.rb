class WorkStateValidator < ActiveModel::EachValidator

  # ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed
  def validate_each(record, attribute, value)
    begin
      result = Courier.valid_work_state? value
    rescue
    end
    record.errors[attribute] << "is not a valid work state, was #{value.inspect}" unless result
  end    
end

