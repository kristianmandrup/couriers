module AddressHelper
  def extract_city options = {}
    case options
    when Symbol
      options
    else
      options[:from] || :munich
    end
  end
end  