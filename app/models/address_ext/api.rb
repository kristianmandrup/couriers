module AddressExt
  module Api
    def for_json
      {:street => street, :city => city, :country => country}
    end

    def get_street
      {:street => street}
    end
  end
end