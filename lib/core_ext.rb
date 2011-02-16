require "pp"
require 'array'
require 'string'
require 'hash'
require 'nil_class'

class Module
  include Party::Proxy
end
