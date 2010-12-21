class Address
  include Mongoid::Document

  field :street,    :type => String

  # N.America
  field :zip,       :type => String

  # Germany (Europe)
  field :postnr,    :type => String

  field :city,      :type => String

  # USA
  field :state,     :type => String

  # Canada
  field :province,  :type => String

  field :country,   :type => String
  
  embedded_in :profile, :inverse_of => :address
  
  validates_length_of :postnr,  :within => 5..5
  validates_length_of :zip,     :within => 6..6
end
