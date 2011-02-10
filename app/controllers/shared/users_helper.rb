module Shared
  module UsersHelper
    def guest_options
     session[:guest_options] ||= {}
    end

    def current_user   
      if !session[:user_id]
        @guest ||= Guest.create(guest_options) 
        return @guest
      end
      if session[:user_id]  
        begin
          clazz = session[:user_class_name].constantize
          @current_user ||= clazz.find session[:user_id] 
          return @current_user
        rescue Exception => e
          @guest ||= Guest.create(guest_options)
        end
      end
    end
  end
end