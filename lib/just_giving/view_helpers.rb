module JustGiving
  module ViewHelpers
    def just_giving_charity_page_url(short_name)
      SimpleDonationIntegration.charity_page_url(short_name) 
    end

    def just_giving_chairty_donation_page_url(charity_id, options={})
      SimpleDonationIntegration.charity_donation_url(charity_id, options)
    end

    def just_giving_fundraising_page_url(short_url)
      SimpleDonationIntegration.fundraising_page_url(short_url) 
    end

    def just_giving_fundraising_donation_url(page_id, options={})
      SimpleDonationIntegration.fundraising_donation_url(page_id, options)
    end
  end
end
