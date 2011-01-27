module Api
  module ResponseHelper
    # these can be used as wrappers by the API functions

    def reply_update obj, name
      puts "reply_update: #{obj.inspect}, #{name}, valid: #{obj.valid?}"
      # reply_invalid_update(obj) and return if !obj.valid?    
      reply_success_update obj, name
    end

    def reply_update_error obj, name                                                       
      puts "reply_update_error: #{name}"
      render_json reply_error("#{humanized obj.class} could not update #{dhumanized name}")
    end

    def reply_get data, name
      reply_ok "#{humanized name} was retrieved"
    end

    def reply_get_error name
      reply_error "Error getting #{dhumanized name}"
    end  

    protected

    def reply_success_update obj, name 
      puts "reply_success_update: #{obj.inspect}, #{name}"
      data = obj.send name
      puts "data: #{data.inspect}"
      json_obj = reply_ok("#{humanized obj.class} #{dhumanized name} was updated").merge(data)
      puts "json obj: #{json_obj}"
      render_json json_obj
    end

    def reply_invalid_update obj
      puts "reply_invalid_update: #{obj.inspect}"                                              
      
      error = obj.errors.values.first.first
      what = obj.errors.keys.first
      json_obj = reply_status(:INVALID_UPDATE, "#{humanized obj.class} update was not valid, #{what} #{error}")
      puts "json obj: #{json_obj}"
      render_json json_obj
    end

    private

    def reply_error message
      reply_status :ERROR, message  
    end

    def reply_ok message
      reply_status :OK, message  
    end

    def reply_status code, message
      {
        status: {
          code:     code.to_s.underscore.upcase,
          message:  message
        }
      }
    end

    def render_json(obj)
      render :json => obj
    end

    def dhumanized obj
      obj.to_s.dhuman
    end

    def humanized obj
      obj.to_s.human
    end
  end
end