module JustGiving
  class Event < API
    def initialize(id)
      @id = id
    end

    # Get details for an event
    def details
      get("v1/event/#{@id}")
    end

    # Get all pages for an event
    def pages
      get("v1/event/#{@id}/pages")
    end
  end
end