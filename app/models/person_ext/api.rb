module PersonExt
  module Api
    def for_json
      {:name => name.for_json, :address => address.for_json}
    end
  end
end