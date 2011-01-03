class ScheduleController < InheritedResources::Base
  before_filter :authenticate_user!

  # show form for creating a new delivery schedule
  def new
  end

  # creates a new schedule
  def create
  end
end
