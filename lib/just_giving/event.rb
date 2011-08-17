module JustGiving
  class Event < API
    def initialize(id)
      @id = id
    end

    def details
      get("v1/event/#{@id}")
    end

    def pages
      get("v1/event/#{@id}/pages")
    end
  end
end