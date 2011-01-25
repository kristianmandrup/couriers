module CourierStateHelper
  
  # delivery_status: "ready|accepted|declined|cancelled|arrived_at_pickup|arrived_at_dropoff|billed",
  def personas
    {
      rolf:     {id: 4, state: 'accepted' },
      lena:     {id: 5, state: 'declined' },
      silke:    {id: 6, state: 'canceled' },
      patricia: {id: 7, state: 'arrived_at_pickup' },
      michael:  {id: 8, state: 'arrived_at_dropoff' },
      chris:    {id: 9, state: 'billed' }
    }
  end

  def directions
    "3,5km to target"
  end

  def pickup
    {
      location: {
        position: {
          latitude:   150.644,
          longitude: -34.397
        },
        address:  {
          street: "Sendlinger Straße 1",
          zip:    "80331",
          city:   "München"
        }    
      },
      contact:  {
        company_name: "Tiramizoo 1",
        name: "Michael Löhr",
        email: "michael.loehr@tiramizoo.com",
        phone: "089123456789"                   
      },
      notes: "Big box"
    }
  end            
  
  def dropoff
    {
      location: {
        position:   {
          latitude:   150.644,
          longitude:  -34.397
        },
        address:  {
          street: "Sendlinger Straße 2",
          zip: "80331",
          city: "München"
        }    
      },
      contact:  {
        company_name: "Tiramizoo 2",
        name: "Philipp Walz",
        email: "philipp.walz@tiramizoo.com",
        phone: "089987654321"
      },
      notes: "Big box"              
    }
  end    

  def delivery_info id
    {
      status: {
        code: 'OK'
      },  
      direction: directions,
      pickup: pickup,
      dropoff: dropoff
    }
  end

  def persona id
    personas[id]
  end

  def service_path id
    service.gsub(/:id/, persona(id))
    service.gsub(/:delivery_id/, '5')
  end
  
  def delivery_args id
    [service_path(id), delivery(id)]
  end
end