class SearchController < InheritedResources::Base
  before_filter :authenticate_user!

  # shows the current tracking info of your delivery in progress
  def couriers
  end
end
