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
         
  field :country, :type => String
  
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
