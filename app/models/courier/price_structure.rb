class Courier::PriceStructure
  include Mongoid::Document

  class << self
    def max_weight_kg
    end

    def max_dimensions_cm
    end

    def max_km
    end
  end

  field :base_price,            :type => Float # price up to km_point

  field :km_price,              :type => Float # price per kilometer beyond km_point
  field :km_point,              :type => String # from this distance, the km_price is effective

  field :cost_per_stop,         :type => Float 
  field :waiting_time,          :type => Float # every 5 min?
  field :unsuccessful_delivery, :type => Float # pickup or delivery could not be made

  field :currency,              :type => String

  validates :currency, :presence => true, :currency => true

  # validates :max_weight_kg,   :numericality => {:within => 1..20000} # 20.0000 kg
  # validates :base_price,      :numericality => {:within => 1..200}
  # validates :km_price,        :numericality => {:within => 1..200}
  # validates :km_point,        :numericality => {:within => 1..20}
  # validates :cost_per_stop,   :numericality => {:within => 1..200}
  # validates :waiting_time,    :numericality => {:within => 1..200}
  # 
  # validates :unsuccessful_delivery,    :numericality => {:within => 1..200}
    
  # embedded_in :service_provider, :inverse_of => :price_structure
end
