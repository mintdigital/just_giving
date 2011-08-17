module JustGiving
  class Charity < API
    def get_charity(id)
      get("v1/charity/#{id}")
    end

    def validate(params)
      post('v1/charity/authenticate', params)
    end
  end
end