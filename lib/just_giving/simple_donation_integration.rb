require 'cgi'

module JustGiving
  class SimpleDonationIntegration
    # Returns url to link to a charity page
    def self.charity_page_url(short_name)
      "#{JustGiving::Configuration::BASE_URI}/#{short_name}/donate" 
    end

    # Returns url for the donation page of a charity
    def self.charity_donation_url(charity_id, options={})
      options = self.parse_options(options)
      url = "#{JustGiving::Configuration::BASE_URI}/donation/direct/charity/#{charity_id}"
      url << self.options_to_query(options) if options.any?
      url
    end

    class << self
      alias :fundraising_page_url :charity_page_url
    end

    # Returns url for the donation page of a fundraising
    def self.fundraising_donation_url(page_id, options={})
      options = self.parse_options(options)
      url = "#{JustGiving::Configuration::BASE_URI}/donation/sponsor/page/#{page_id}"
      url << self.options_to_query(options) if options.any?
      url
    end

    private
    
    # Remove options we are not interested in
    def self.parse_options(options)
      available_options = [:amount, :frequency, :exit_url, :donation_id]
      options.delete_if{|key, value| !available_options.include?(key)}
    end

    # This is a pretty niave implementation but we control the input so it suffices
    def self.camelize(snake_case_word)
      snake_case_word.to_s.gsub(/_(.)/){$1.upcase}
    end

    def self.options_to_query(options)
      "?#{options.collect{|k,v| "#{self.camelize(k)}=#{CGI.escape(v.to_s)}"}.join("&")}"
    end
  end
end
