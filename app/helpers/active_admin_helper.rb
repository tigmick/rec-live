module ActiveAdminHelper
  # For ActiceAdmin
   def url_for(options = nil) # :nodoc:
      case options
      when String
        options
      when :back
        _back_url
      end
    end
end