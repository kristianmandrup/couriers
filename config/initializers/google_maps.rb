module GeoMap
  class << self    
    def env 
      ENV['HEROKU_SITE'] || Rails.env.downcase || 'development'
    end
  
    def config
      @config ||= YAML.load_file("#{Rails.root}/config/google_map.yml")[env]
    end

    def google_key
      config['google_key'] 
    end

    def geo_coder
      @geo_coder ||= Graticule.service(:google).new google_key
    end
  end
end

