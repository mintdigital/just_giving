module JustGiving
  class Fundraising < API
    def initialize(short_name=nil)
      @short_name = short_name
    end
    
    def pages
      get("v1/fundraising/pages", :basic_auth => true)
    end

    def create(params)
      put("v1/fundraising/pages", {:basic_auth => true}.merge(params))
    end

    def short_name_registered?
      head("v1/fundraising/pages/#{@short_name}")
    end

    def page
      get("v1/fundraising/pages/#{@short_name}")
    end

    def donations(page=1, per_page=50)
      get("v1/fundraising/pages/#{@short_name}/donations?pageNum=#{page}&page_size=#{per_page}",
        :basic_auth => true)
    end

    def update_story(story)
      post("v1/fundraising/pages/#{@short_name}", {:basic_auth => true}.merge({:storySupplement => story}))
    end

    def upload_image
      # TODO
    end
  end
end