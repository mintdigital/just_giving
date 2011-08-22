module JustGiving
  class Charity < API
    # Get charity by id
    def get_charity(id)
      get("v1/charity/#{id}")
    end

    # Validate charity username/password
    def validate(params)
      post('v1/charity/authenticate', params)
    end
  end
end