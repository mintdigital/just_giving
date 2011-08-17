module JustGiving
  class Search < API
    def search_charities(query, page=1, per_page=10)
      get("v1/charity/search?q=#{query}&page=#{page}&pageSize=#{per_page}")
    end

    def search_events(query, page=1, per_page=10)
      get("v1/event/search?q=#{query}&page=#{page}&pageSize=#{per_page}")
    end
  end
end