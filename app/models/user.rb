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
end
