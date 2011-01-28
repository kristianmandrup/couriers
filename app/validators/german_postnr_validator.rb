class GermanPostnrValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    begin
      return if value.blank?
      too_short if value.size < 6
      too_long if value.size > 6
      not_a_number if !(value =~ /\D/) # if matches any character not a number
    rescue
    end
  end    

  def too_short
    record.errors[attribute] << "is too short"
  end
  
  def too_short
    record.errors[attribute] << "is too short"
  end

  def not_a_number
    record.errors[attribute] << "is not a number"
  end
end

