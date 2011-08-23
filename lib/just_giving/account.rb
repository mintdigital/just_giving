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

    # This validates a username/password
    def validate(params)
      post('v1/account/validate', params)
    end

    # Confirm if an email is available or not
    def available?
      begin
        head("v1/account/#{@email}")
        return false
      rescue JustGiving::NotFound
        return true
      end
    end

    # Update password
    def change_password(params)
      post('v1/account/changePassword', params)
    end

    # Send password reminder
    def password_reminder
      response = get("v1/account/#{@email}/requestpasswordreminder")
      (response && response.errors) ? response : true
    end
  end
end
