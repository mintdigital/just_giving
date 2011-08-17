module JustGiving
  class Donation < API
    def initialize(id)
      @id = id
    end
    
    # Get the details of a specific donation
    def details
      get("v1/donation/#{@id}")
    end

    # Get the status of a specific donation
    def status
      get("v1/donation/#{@id}/status")
    end
  end
end