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
    def create(params)
      put('v1/account', params)
    end

    def validate(params)
      post('v1/account/validate', params)
    end

    def available?
      head("v1/account/#{@email}")
    end

    def change_password(params)
      post('v1/account/changePassword', params)
    end

    def password_reminder
      get("v1/account/#{@email}/requestpasswordreminder")
    end
  end
end