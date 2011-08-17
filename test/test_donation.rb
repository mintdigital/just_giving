require 'helper'

class TestDonation < Test::Unit::TestCase
  def setup
    JustGiving::Configuration.application_id = '2345'
  end

  context 'getting a donation' do
    should 'return known donation' do
      stub_get('/v1/donation/1/status').to_return(
        :body => fixture('donation_status_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      donation = JustGiving::Donation.new(1).status
      assert_equal 2.0, donation['amount']
      assert_equal 1234, donation['donationId']
      assert_equal "Accepted", donation['status']
    end

    should 'not return unkown donation' do
      stub_get('/v1/donation/1/status').to_raise(JustGiving::NotFound)
      assert_raise JustGiving::NotFound do
        donation = JustGiving::Donation.new(1).status
      end
    end
  end
end