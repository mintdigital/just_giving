require 'just_giving/api'

module JustGiving
  class Account < API
    def initialize(email=nil)
      @email = email
    end

    def pages
      get("v1/account/#{@email}/pages")
    end
  end
end