module CompanyExt
  module Api
    def for_json
      {:name => name, :address => address.for_json, :contact => contact.for_json }
    end
  end
end
