require 'helper'

class TestDonation < Test::Unit::TestCase
  def setup
    JustGiving::Configuration.application_id = '2345'
  end

  context 'getting a donation' do
    should 'return known donation' do
      stub_get('/v1/donation/1/status').to_return(
        :body => fixture('donation_status_success.xml'),
        :headers => {:content_type =>  'application/xml; charset=utf-8'})
      donation = JustGiving::Donation.new(1).status
      assert_equal "1", donation['donationResult']['amount']
      assert_equal "1", donation['donationResult']['donationId']
      assert_equal "Pending", donation['donationResult']['status']
    end

    should 'not return unkown donation' do
      stub_get('/v1/donation/1/status').to_raise(JustGiving::NotFound)
      assert_raise JustGiving::NotFound do
        donation = JustGiving::Donation.new(1).status
      end
    end
  end
end