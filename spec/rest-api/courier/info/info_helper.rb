module CourierInfoHelper
  def personas
    {
      steffan:  {id: 1, available: true, biking: true, delivery: false  },
      matthias: {id: 2, available: true, biking: true, delivery: true   },
      barbie:   {id: 3, available: false, biking: false, delivery: true  }
    }
  end

  def persona id
    personas[id]
  end

  def service_path id
    service.gsub(/:id/, persona(id))
  end

  def info id
    courier = persona(id)
    work_state  = courier[:available] ? 'available' : 'not_available'
    travel_mode = courier[:biking] ? 'biking' : 'driving'
    current_delivery = courier[:delivery] ? Delivery.create_from(:munich).state = 'accepted' : nil    
    { 
      work_state: work_state,
      travel_mode: travel_mode
      current_delivery: current_delivery
    }
  end
end