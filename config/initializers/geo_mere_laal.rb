# GML_GMAP_APIKEY = "ABQIAAAAyeCvmxkIRps-zjsGlV3blxQz-J5LV6rASCxLYU1xMqKNc_nHIxSc17Ip2zTUk8uXq-eVwHKuhqgunQ" 

# module ActionView
#   module Helpers
#     module FormHelper
#       def kristian_field(object, method, options = {}, html_options = {})
#         p "foh - kristian_field: #{options.inspect}"
#         i = ActionView::Helpers::InstanceTag.new(object, method, self, options.delete(:object))
#         p i.methods.sort
#         i.to_kristian_tag("Kristian", options, html_options)
#       end
# 
#       def kristian_tag(name, value = nil, priority_languages = nil, html_options = {})
#         content_tag :input, value || "Kristian", { "name" => name, "id" => name }.update(html_options.stringify_keys)
#       end
#     end    
# 
#     class InstanceTag
#       def to_kristian_tag(default_value, options, html_options)
#         p "to_kristian_tag: #{html_options}"
#         html_options = html_options.stringify_keys
#         add_default_name_and_id(html_options)
#         value = default_value
#         content_tag("input", value, options, html_options)
#       end
#     end
#           
#     class FormBuilder
#       def kristian_field(method, options = {}, html_options = {})
#         p "fb - kristian_field"
#         @template.kristian_field(@object, method, options, html_options)
#       end
#     end    
#   end
# end        
# 
# module ActionView
#   module Helpers
#     class FormBuilder
#       def hello
#         puts "hello"
#       end
#     end
#   end
# end