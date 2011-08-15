require 'just_giving/connection'
require 'just_giving/request'

module JustGiving
  class API
    include Connection
    include Request
  end
end