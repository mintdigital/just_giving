module JustGiving
  class Configuration
    BASE_URI_MAP = {
      :production => "http://www.justgiving.com",
      :staging => "http://v3-staging.justgiving.com",
      :sandbox => "http://v3-sandbox.justgiving.com"
    }

    @@application_id = nil
    @@environment = :staging
    @@ca_path =  "/usr/lib/ssl/certs"

    ## This is your Just Giving application id
    def self.application_id
      @@application_id
    end

    def self.application_id=(id)
      @@application_id = id
    end

    def self.base_uri
      BASE_URI_MAP[self.environment]
    end

    ## This can be :sandbox, :staging or :production and sets what endpoint to use
    def self.environment=(env)
      @@environment = env
    end

    def self.environment
      @@environment
    end

    ## The API endpoint
    def self.api_endpoint
      raise JustGiving::InvalidApplicationId.new if !application_id
      case environment
        when :sandbox then "https://api-sandbox.justgiving.com/#{application_id}"
        when :staging then "https://api-staging.justgiving.com/#{application_id}"
        else "https://api.justgiving.com/#{application_id}"
      end
    end

    ## Path to the systems CA cert bundles
    def self.ca_path=(path)
      @@ca_path = path
    end
    
    def self.ca_path
      @@ca_path
    end

    ## Username/password for basic auth
    def self.username
      @@username
    end

    def self.username=(username)
      @@username = username
    end

    def self.password=(password)
      @@password = password
    end

    def self.password
      @@password
    end
  end
end
