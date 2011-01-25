module CourierStateHelper
  
  # delivery_status: "ready|accepted|declined|cancelled|arrived_at_pickup|arrived_at_dropoff|billed",
  def personas
    {
      rolf:     {id: 4, state: 'accepted' },
      lena:     {id: 5, state: 'declined' },
      silke:    {id: 6, state: 'canceled' },
      patricia: {id: 7, state: 'arrived_at_pickup' },
      michael:  {id: 8, state: 'arrived_at_dropoff' },
      chris:    {id: 9, state: 'billed' },
    }
  end

  def persona id
    personas[id]
  end

  def service_path id
    service.gsub(/:id/, persona(id))
  end

  #   state: "ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed",
  #   location: {
  #     longitude: -34.397, 
  #     latitude: 150.644
  #   }
  def delivery id
    state = persona(id)[:state]
    { 
      state: state,
      location: {
        longitude: -34.397,
        latitude:  150.644
      }
    }
  end

  def delivery_state_args id
    [service_path(id), delivery_state(id)]
  end
  
  def delivery_args id
    [service_path(id), delivery(id)]
  end
end