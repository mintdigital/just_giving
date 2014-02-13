require 'helper'

class TestAccount < Test::Unit::TestCase
  def setup
    JustGiving::Configuration.application_id = '2345'
  end
  
  context 'Getting pages' do
    should 'get pages for account' do
      stub_get('/v1/account/test@example.com/pages').with(:headers => {'Accept'=>'application/json'}).to_return(
        :body => fixture('account_list_all_pages.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      account = JustGiving::Account.new('test@example.com')
      pages = account.pages
      assert_equal 'Alwyn\'s page', pages.first['pageTitle']
      assert_equal 'Active', pages.first['pageStatus']
      assert_equal 1, pages.first['designId']
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
      stub_put('/v1/account').with({'Accept'=>'application/json', 'Content-Length'=>'0'}).to_return(
        :body => fixture('account_create_success.json'),
        :headers =>  {:content_type =>  'application/json; charset=utf-8'})
      account = JustGiving::Account.new.create({:registration => {:email => 'test@example.com'}})
      assert_equal 'test@example.com', account["email"]
    end

    should 'not create account with bad params' do
      stub_put('/v1/account').to_return(:body => fixture('account_create_fail.json'),
        :headers =>  {:content_type =>  'text/xml; charset=utf-8'}, :status => 400)
      account = JustGiving::Account.new.create({})
      assert account.errors
    end
  end

  context 'Validate account' do
    should 'return invalid account' do
      stub_post('/v1/account/validate').with({'Accept'=>'application/json'}).to_return(
        :body => "{\"consumerId\":0,\"isValid\":false}", :headers => {:content_type =>  'application/json; charset=utf-8'})
      account = JustGiving::Account.new.validate(:email => 'test@example.com', :password => 'secret')
      assert !account["isValid"]
    end

    should 'return valid account' do
      stub_post('/v1/account/validate').with({'Accept'=>'application/json'}).to_return(
        :body => "{\"consumerId\":1,\"isValid\":true}", :headers => {:content_type =>  'application/json; charset=utf-8'})
      account = JustGiving::Account.new.validate(:email => 'test@example.com', :password => 'secret')
      assert account["isValid"]
      assert_equal 1, account["consumerId"]
    end
  end

  context 'Checking if an email is available' do
    should 'return email is not available' do
      stub_head('/v1/account/test@example.com').with({
        'Accept'=>'application/json'
      }).to_return({
        :status => 200, 
        :headers => {
          :content_type =>  'application/json; charset=utf-8'
        },
        :body => "{}"
      })
      assert !JustGiving::Account.new('test@example.com').available?
    end

    should 'return email is available' do
      stub_head("/v1/account/test@example.com").with({
        'Accept'=>'application/json'
      }).to_return({
        :status => 404, 
        :headers => {
          :content_type => 'application/json; charset=utf-8'
        },
        :body => "{}"
      })
      assert JustGiving::Account.new('test@example.com').available?
    end
  end

  context 'Changing password' do
    should 'change password' do
      stub_post('/v1/account/changePassword').with({'Accept'=>'application/json'}).to_return(
        :body => "{\"success\": true}", :headers => {:content_type =>  'application/json; charset=utf-8'})
      response = JustGiving::Account.new.change_password(:emailAddress => 'test@example.com', :newPassword => 'secret',
        :currentPassword => 'password')
      assert response["success"]
    end

    should 'not change password' do
      stub_post('/v1/account/changePassword').with({'Accept'=>'application/json'}).to_return(
        :body => "{\"success\": false}", :headers => {:content_type =>  'application/json; charset=utf-8'})
      response = JustGiving::Account.new.change_password(:emailAddress => 'test@example.com', :newPassword => 'secret',
        :currentPassword => 'password')
      assert !response["success"]
    end
  end

  context 'Password reminder' do
    should 'send password reminder' do
      stub_get('/v1/account/test@example.com/requestpasswordreminder').with({
        'Accept'=>'application/json'
      }).to_return({
        :status => 200, 
        :headers => {
          :content_type =>  'application/json; charset=utf-8'
        },
        :body => "{}"
      })
      assert JustGiving::Account.new('test@example.com').password_reminder
    end

    should 'not sent password reminder' do
      stub_get('/v1/account/test@example.com/requestpasswordreminder').with({
        'Accept'=>'application/json'
      }).to_return({
        :status => 400, 
        :body => "[{\"id\":\"AccountNotFound\",\"desc\":\"An account with that email address could not be found\"}]",
        :headers => {:content_type =>  'application/json; charset=utf-8'}
      })
      response = JustGiving::Account.new('test@example.com').password_reminder
      assert response.errors
    end
  end
end
