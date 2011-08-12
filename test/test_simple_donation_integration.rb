require 'helper'

class TestSimpleDonationIntegration < Test::Unit::TestCase
  should "return charity url" do
    assert_equal "http://www.justgiving.com/short_name/donate", JustGiving::SimpleDonationIntegration.charity_page_url('short_name') 
  end
end
