require 'profile/class_methods'

class Profile
  include Mongoid::Document

  # Profile
  field :description, :type => String
  field :url,         :type => String
  field :avatar,      :type => String # file upload of profile picture
  
  embedded_in :courier, :inverse_of => :profile

  extend ClassMethods
  
  def to_s
%Q{
description: #{description}
webpage: #{webpage_url}
avatar: #{avatar}
}
  end  
end