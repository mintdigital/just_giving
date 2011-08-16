require 'just_giving/api'

module JustGiving
  class Account < API
    def initialize(email=nil)
      @email = email
    end

    # This lists all the fundraising pages for the supplied email
    def pages
      get("v1/account/#{@email}/pages")
    end

    # This creates an user account with Just Giving
    # Note that currently bad params raise a 400 - these should ideally return the errors
    def create(params)
      put("v1/account", params)
    end
  end
end