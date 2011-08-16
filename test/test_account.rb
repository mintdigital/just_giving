require 'helper'

class TestAccount < Test::Unit::TestCase
  def setup
    JustGiving::Configuration.application_id = '2345'
  end
  
  context 'Getting pages' do
    should 'get pages for account' do
      stub_get('/v1/account/test@example.com/pages').with(:headers => {'Accept'=>'application/xml'}).to_return(
        :body => fixture('account_list_all_pages.xml'),
        :headers => {:content_type =>  'application/xml; charset=utf-8'})
      account = JustGiving::Account.new('test@example.com')
      assert_equal 'Alwyn’s page', account.pages['fundraisingPages']['fundraisingPage']['pageTitle']
      assert_equal 'Active', account.pages['fundraisingPages']['fundraisingPage']['pageStatus']
      assert_equal '1', account.pages['fundraisingPages']['fundraisingPage']['designId']
    end

    should 'raise 404 on account not found' do
      stub_get('/v1/account/test@example.com/pages').to_raise(JustGiving::NotFound)
      account = JustGiving::Account.new('test@example.com')
      assert_raise JustGiving::NotFound do
        account.pages
      end
    end
  end

  context 'Creating account' do
    should 'create account successfully' do
      stub_put('/v1/account').with({'Accept'=>'application/xml', 'Content-Length'=>'0'}).to_return(
        :body => fixture('account_create_success.xml'),
        :headers =>  {:content_type =>  'application/xml; charset=utf-8'})
      account = JustGiving::Account.new.create({:registration => {:email => 'test@example.com'}})
      assert_equal "test@example.com", account["accountRegistration"]["email"]
    end

    should 'not create account with bad params' do
      stub_put('/v1/account').to_return(:body => fixture('account_create_fail.xml'),
        :headers =>  {:content_type =>  'text/xml; charset=utf-8'}, :status => 400)
        assert_raise JustGiving::BadRequest do
          account = JustGiving::Account.new.create({})
        end
    end
  end
end