module CourierInfoHelper
  def personas
    {
      steffan:  {id: 1, longitude: 48.1, :latitude: 12  },
      matthias: {id: 2, longitude: 48.2, :latitude: 11  },
      barbie:   {id: 3, longitude: 48.3, :latitude: 10  }
    }
  end

  def persona id
    personas[id]
  end

  def service_path id
    service.gsub(/:id/, persona(id))
  end

  def location id
    courier = persona(id)
    longitude  = courier[:longitude]
    latitude  = courier[:latitude]
    { 
      longitude: longitude,
      latitude: latitude
    }
  end
end