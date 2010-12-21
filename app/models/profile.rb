class Profile
  include Mongoid::Document

  # Profile
  field :description, :type => String
  field :webpage_url, :type => String

  field :avatar,      :type => String # file upload of profile picture
end