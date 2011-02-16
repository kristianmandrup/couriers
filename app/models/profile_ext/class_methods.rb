module ProfileExt
  module ClassMethods 
    include ::OptionExtractor
    
    def create_empty
      Profile.new 
    end

    def create_for options
      profile               = create_empty
      profile.url           = extract_url         options
      profile.description   = extract_description options
      profile.avatar        = extract_avatar      options
      profile
    end    
  end
end