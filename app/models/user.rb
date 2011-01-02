# Professional booker: retailer, shop etc.

class User
  include Mongoid::Document
  include Roles::Mongoid 

  strategy :role_string, :default

  valid_roles_are :admin, :guest, :customer, :courier, :courier_company
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  field :country, :type => String
end
