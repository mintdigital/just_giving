require 'helper'

class TestSimpleDonationIntegration < Test::Unit::TestCase
  should "return charity url" do
    assert_equal "#{JustGiving::Configuration.base_uri}/short_name/donate", JustGiving::SimpleDonationIntegration.charity_page_url('short_name') 
  end

  context "charity donation url" do
    should "return charity donation url" do
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/direct/charity/2050", JustGiving::SimpleDonationIntegration.charity_donation_url(2050)
    end

    should "accept valid options" do
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/direct/charity/2050?amount=2", JustGiving::SimpleDonationIntegration.charity_donation_url(2050, :amount => 2)
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/direct/charity/2050?frequency=single", 
        JustGiving::SimpleDonationIntegration.charity_donation_url(2050, :frequency => 'single')
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/direct/charity/2050?exitUrl=http%3A%2F%2Fwww.myredirecturl.com%2Fpath", 
        JustGiving::SimpleDonationIntegration.charity_donation_url(2050, :exit_url => 'http://www.myredirecturl.com/path')
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/direct/charity/2050?donationId=JUSTGIVING-DONATION-ID", 
        JustGiving::SimpleDonationIntegration.charity_donation_url(2050, :donation_id => 'JUSTGIVING-DONATION-ID')
    end

    should "reject unknown options" do
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/direct/charity/2050", JustGiving::SimpleDonationIntegration.charity_donation_url(2050, :bogus => 1)
    end
  end

  should "return fundraising url" do
    assert_equal "#{JustGiving::Configuration.base_uri}/test/donate", JustGiving::SimpleDonationIntegration.fundraising_page_url('test')
  end

  context "fundraising donation url" do
    should "return fundraising donation url" do
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/sponsor/page/12345", JustGiving::SimpleDonationIntegration.fundraising_donation_url(12345)    
    end

    should "accept valid options" do
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/sponsor/page/12345?amount=2", JustGiving::SimpleDonationIntegration.fundraising_donation_url(12345, :amount => 2)
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/sponsor/page/12345?exitUrl=http%3A%2F%2Fwww.myredirecturl.com%2Fpath", 
        JustGiving::SimpleDonationIntegration.fundraising_donation_url(12345, :exit_url => 'http://www.myredirecturl.com/path')
      assert_equal "#{JustGiving::Configuration.base_uri}/donation/sponsor/page/12345?donationId=JUSTGIVING-DONATION-ID", 
        JustGiving::SimpleDonationIntegration.fundraising_donation_url(12345, :donation_id => 'JUSTGIVING-DONATION-ID')
    end
  end
end
