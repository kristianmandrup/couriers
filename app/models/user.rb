class User
  include Mongoid::Document
  include Roles::Mongoid 

  strategy :role_string
  valid_roles_are :admin,   :guest, 
                  :seller,  :professional, :private,
                  :individual_courier, :courier_company

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  field :country,       :type => String
  field :country_code,  :type => String  
  field :language,      :type => String  

  def into_json
    j = self.to_json
    {:email => j[:email], :country => j[:country] }
  end

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    case_insensitive_keys.each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
         login = attributes.delete(:login)
         record = find_record(login)
      else  
        record = where(attributes).first
      end  
    end  
    user_not_found(required_attributes) unless record
    record
  end

  def self.user_not_found required_attributes
    record = new

    required_attributes.each do |key|
      value = attributes[key]
      record.send("#{key}=", value)
      record.errors.add(key, value.present? ? error : :blank)
    end
  end

  def self.find_record_alt(login)
    where("function() {return this.username == '#{login}' || this.email == '#{login}'}")
  end  

  
  def has_address?
    true
  end

  def has_profile?
    false
  end

  def has_bankaccount?
    false
  end

  def has_vehicles?
    false
  end

  def is_person?
    false
  end

  def is_company?
    false
  end
end
