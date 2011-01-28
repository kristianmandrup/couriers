class Admin < User
  include Mongoid::Document
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable
  
  # # Include default devise modules. Others available are:
  # # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  # 
end
