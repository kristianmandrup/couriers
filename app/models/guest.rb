class Guest
  include Mongoid::Document  

  # field :login,           :type => String
  # field :password,        :type => String

  # field :country,         :type => String
  # field :country_code,    :type => String
  # field :language,        :type => String  
  # field :language_code,   :type => String  
  
  attr_accessor :login, :password
  attr_accessor :country, :country_code, :language, :language_code, :city
    
  def self.create options = {}
    Guest.new options
  end

  def save
    false
  end 
  
  def save!
    false
  end

  def is? role
    role == :guest
  end

  def has_role? role
    is? role
  end

  def has_roles? *roles
    false
  end  

  def has_any_role? *roles
    roles.flat_uniq.to_symbols.include?(:guest)
  end  
end