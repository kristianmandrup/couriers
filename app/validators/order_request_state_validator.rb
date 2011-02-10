class OrderRequestStateValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    begin
      result = Order::Request.valid_state? value
    rescue
    end
    record.errors[attribute] << "is not a valid order request state" unless result
  end    
end

