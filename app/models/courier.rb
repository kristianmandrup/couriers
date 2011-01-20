class Courier < User 
  include Mongoid::Document  

  field :number, :type => Integer
    
  embeds_one :bank_account
  embeds_one :price_structure
  
  embeds_many :vehicles
  
  embeds_one :delivery

  field :work_state, :type => String

  validates :work_state, :work_state => true
  
  after_create :set_work_state

  def set_work_state
    self.work_state = 'not_available' if work_state.blank?
  end

  def eta
    x = rand(3) > 1 ? rand(200) : rand(30)
    TimePeriod.to_s rand(100) + 60 + x
  end

  def rating
    rand(3) + rand(3) + 1    
  end

  def price  
    p = rand(10) + rand(6) + 5
    "#{p} euro"
  end

  def for_json
    {:eta => eta, :rating => rating, :price => price}
  end
  
  class << self   
    def work_states
      [:available, :not_available]
    end    
    
    def create_individual options = {}
      ci = Courier::Individual.new      
      ci.person = options[:person] if options[:person]
      ci.person.address = options[:address] if options[:address]
      ci.delivery = Courier::Delivery.create_from :munich
      ci.work_state = work_states[0].to_s
      ci
    end

    def create_company options = {}
      co = Courier::Company.new
      co.company = Company.create_from :munich
      co
    end

    def create_from city = :munich 
      puts "create_from: #{city}"
      # person = Person.create_from :munich
      # person.address = Address.get_random_from :munich

      type = [:individual, :company].pick_one

      case type
      when :individual        
        Courier::Individual.create_from city
      when :company
        Courier::Company.create_from city
      end
    end
    
    def available city = :munich
      number = rand(5) +1
      number.times.inject([]) do |res, n| 
        res << create_from(city)
        res 
      end
    end
  end
end
