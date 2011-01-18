require "geo_mere_laal" 
require "geo_mere_laal_helper"  

puts "Include GeoMereLaalHelper into ActionView"
ActionView::Base.send(:include, GeoMereLaalHelper)  # The helper beauty comes here                            
ActionView::Helpers::FormOptionsHelper.send(:include, GeoMereLaalHelper) # The helper beauty comes here
