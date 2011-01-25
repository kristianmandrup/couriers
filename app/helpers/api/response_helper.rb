module Api
  module ResponseHelper
    # these can be used as wrappers by the API functions

    def reply_update obj, name
      reply_invalid_update(event) and return if !obj.valid?    
      reply_success_update obj, name
    end

    def reply_update_error obj, name
      reply_error "#{humanized obj} could not update #{dhumanized name}"
    end

    def reply_get data, name
      reply_ok "#{humanized name} was retrieved"
    end

    def reply_get_error name
      reply_error "Error getting #{dhumanized name}"
    end  

    protected

    def reply_success_update obj, name
      reply_ok  "#{humanized obj.class} #{dhumanized name} was updated"
    end

    def reply_invalid_update obj
      reply_status :INVALID_UPDATE, "#{humanized obj} update was not valid"
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
      obj.to_s.humanize.downcase
    end

    def humanized obj
      obj.to_s.humanize
    end
  end
end