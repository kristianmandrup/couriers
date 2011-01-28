class User
  include Mongoid::Document
  include Roles::Mongoid 
  
  strategy :role_string
  valid_roles_are :admin,   :guest, 
                  :seller,  :professional, :private,
                  :individual_courier, :courier_company

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
         
  field :country,       :type => String
  field :country_code,  :type => String  
  field :language,      :type => String  

  def into_json
    j = self.to_json
    {:email => j[:email], :country => j[:country] }
  end

  def random_user
    self.email = "courier_#{rand(100)+1}@messenger.com"
    self.password = "123456"
    self.password_confirmation = "123456"
  end
  
  def person *args
  end

  def full_name *args
  end

  def company *args
  end         
end
