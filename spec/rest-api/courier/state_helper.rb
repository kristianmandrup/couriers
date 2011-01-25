module CourierStateHelper
  def personas
    {
      steffan:  {id: 1, available: true   },
      matthias: {id: 2, available: true   },
      barbie:   {id: 3, available: false  },
    }
  end

  def persona id
    personas[id]
  end

  def service_path id
    service.gsub(/:id/, persona(id))
  end

  def available id
    ws = persona(id)[:available] ? 'available' : 'not_available'
    { 
      work_state: ws}
    }
  end
end