class Admin
  class RegistrationsController < ApplicationController
    # before_filter :authenticate_user!, :except => [:new]  

    # list all registrations
    def index
    end

    # show screen to decline or confirm registration
    def confirmation
    end
  end
end