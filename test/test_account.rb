require 'helper'

class TestAccount < Test::Unit::TestCase  
  should "get pages for account" do
    stub_get("v1/account/test@example.com/pages").to_return(:body => fixture('account_list_all_pages.xml'), 
      :headers => {:content_type =>  "text/xml; charset=utf-8"})
    account = JustGiving::Account.new('test@example.com')
    assert_equal "Alwyn’s page", account.pages["fundraisingPages"]["fundraisingPage"]["pageTitle"]
    assert_equal "Active", account.pages["fundraisingPages"]["fundraisingPage"]["pageStatus"]  
    assert_equal "1", account.pages["fundraisingPages"]["fundraisingPage"]["designId"]      
  end
  
  should "raise 404 on account not found" do
    stub_get("v1/account/test@example.com/pages").to_raise(JustGiving::NotFound)
    account = JustGiving::Account.new('test@example.com')
    assert_raise JustGiving::NotFound do
      account.pages
    end
  end
end