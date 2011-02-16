module LocationExt
  module Api
    def for_json
      {:latitude => latitude, :longitude => longitude }
    end
  end
end