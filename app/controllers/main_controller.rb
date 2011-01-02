class MainController < InheritedResources::Base
  def index
    @location = true # geolocation here!
  end
end
