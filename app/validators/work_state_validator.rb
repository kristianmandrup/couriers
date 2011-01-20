class WorkStateValidator < ActiveModel::EachValidator

  # ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed
  def work_states
    [:available, :not_available]
  end

  def validate_each(record, attribute, value)
    result = work_states.include? value.to_sym    
    record.errors[attribute] << "is not a valid work state" unless result
  end
end

