module JustGiving
  class Fundraising < API
    def initialize(short_name=nil)
      @short_name = short_name
    end
    
    # Get all pages
    def pages
      get("v1/fundraising/pages", :basic_auth => true)
    end

    # Create a new fundraising page
    def create(params)
      put("v1/fundraising/pages", {:basic_auth => true}.merge(params))
    end

    # Check if a short name is registered
    def short_name_registered?
      begin
        head("v1/fundraising/pages/#{@short_name}")
        return true
      rescue JustGiving::NotFound
        return false
      end
    end

    # Get a specific page
    def page
      get("v1/fundraising/pages/#{@short_name}")
    end

    # Get all donations per page
    def donations(page=1, per_page=50)
      get("v1/fundraising/pages/#{@short_name}/donations?pageNum=#{page}&page_size=#{per_page}",
        :basic_auth => true)
    end

    # Update a pages story
    def update_story(story)
      post("v1/fundraising/pages/#{@short_name}", {:basic_auth => true}.merge({:storySupplement => story}))
    end

    def upload_image
      # TODO
    end

    def suggest
      # TODO
    end
  end
end
