class MainController < InheritedResources::Base
  def index
    @location = true # geolocation here!
    @quote = Quote.new
  end
end
