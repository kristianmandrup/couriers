module TiramizooApp
  def self.geocoder
    GeoMap.geo_coder(:env => :rails).instance
  end
end
  