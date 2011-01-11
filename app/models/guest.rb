class Guest
  include Mongoid::Document  

  attr_accessor :login
  attr_accessor :password
    
  def self.create
    Guest.new
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