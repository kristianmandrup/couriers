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
    number = persona(id)[:id]
    service.gsub(/:courier_id/, number.to_s) << '.json'
  end

  def state id
    work_state = persona(id)[:available] ? 'available' : 'not_available'
    { 
      work_state: work_state
    }
  end
end