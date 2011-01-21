# module GeoMap
#   class ServiceAdapter
#     attr_reader :geo_coder
# 
#     def geocode location_str
#       raise 'method #geocode must be implemented by adapter subclass'
#     end
# 
#     def reverse_geocode latitude, longitude
#       raise 'method #reverse_geocode should be implemented by adapter subclass'
#     end          
# 
#     protected
#     
#     def env 
#       ENV['HEROKU_SITE'] || Rails.env.downcase || 'development'
#     end
#   
#     def config
#       @config ||= YAML.load_file("#{Rails.root}/config/google_map.yml")[env]
#     end
# 
#     def google_key
#       config['google_key'] 
#     end    
#   end
#   
#   class GraticuleAdapter < ServiceAdapter   
#     def initialize service_name = :google
#       @geo_coder ||= Graticule.service(service_name).new google_key
#     end
#       
#     def geocode location_str
#       geo_coder.locate location_str
#     end    
#   end
# 
#   class GeocodeAdapter < ServiceAdapter
#     def initialize service_name = :google
#       @geo_coder ||= Geocode.new_geocoder service_name, {:google_api_key => google_key}
#     end
#       
#     def geocode location_str
#       geo_coder.geocode(location_str).extend GeocodeAPI
#     end
# 
#     module GeocodeAPI      
#       def country
#         country_api["CountryNameCode"]
#       end
# 
#       def country_name
#         country_api["CountryName"]
#       end
#       
#       def state
#         adm_api["AdministrativeAreaName"]
#       end
#       
#       def postal_code
#         subadm_api["Locality"]["PostalCode"]["PostalCodeNumber"]
#       end 
#       alias_method :zip, :postal_code
#       
#       def street
#         subadm_api["Thoroughfare"]["ThoroughfareName"]
#       end
# 
#       def city
#         subadm_api["SubAdministrativeAreaName"]
#       end
# 
#       def latitude
#         coords[0]
#       end
# 
#       def longitude
#         coords[1]
#       end
#       
#       protected
# 
#       def api
#         data["Placemark"].first
#       end
# 
#       def coords
#         api["Point"]["coordinates"]
#       end
# 
#       def adr_api
#         api["AddressDetails"]
#       end 
# 
#       def country_api
#         adr_api["Country"]
#       end
#       
#       def adm_api
#         country_api["AdministrativeArea"]        
#       end
#       
#       def subadm_api
#         adm_api["SubAdministrativeArea"]
#       end
#     end
# 
#     def reverse_geocode latitude, longitude
#       geo_coder.reverse_geocode "#{latitude}, #{longitude}"
#     end      
#   end
# 
#   
#   class << self    
#     def geo_coder type = :geocode, service_name = :google
#       "GeoMap::#{type.to_s.classify}Adapter".constantize.new service_name
#     end 
#     
#     def geocode location_str
#       geo_coder.geocode location_str
#     end    
#   end
# end
# 
