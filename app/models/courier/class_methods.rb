class Courier < ::User
  module ClassMethods
    include ::OptionExtractor

    def valid_account_states
      [:active, :inactive, :pending]
    end

    def valid_account_state? state
      state.blank? || valid_account_states.include?(state.to_sym) 
    end

    def valid_work_states
      [:available, :not_available]
    end    

    def valid_work_state? state
      valid_work_states.include?(state.to_sym) 
    end

    def heard_from
      ['Facebook', 'Twitter', 'My courier company', 'Courier colleagues', 'Customers', 'Press']
    end  
        
    def available
      in_db = Courier.all.to_a
      in_db.empty? ? create_random(6, :from => :munich, :type => :individual) : in_db
    end
  
    def create_one_random options = {}
      create_courier(options)
    end
  
    def create_random number, options = {}
      number.times.inject([]) do |res, n| 
        res << create_one_random(options)
        res 
      end
    end
  end
end