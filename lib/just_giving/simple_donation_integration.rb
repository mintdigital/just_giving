module JustGiving
  class SimpleDonationIntegration
    def self.charity_page_url(short_name)
      "#{JustGiving::Config::BASE_URI}/#{short_name}/donate" 
    end
  end
end
