require 'helper'

class TestCharity < Test::Unit::TestCase
  def setup
    JustGiving::Configuration.application_id = '2345'
  end
  
  context 'fetching a charity' do
    should 'get a charity by id' do
      stub_get('/v1/charity/2050').with(:headers => {'Accept'=>'application/json'}).to_return(
        :body => fixture('charity_get_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      charity = JustGiving::Charity.new.get_charity(2050)
      assert_equal 2050, charity["id"]
      assert_equal "The Demo Charity", charity["smsShortName"]
    end
  end
  
  context 'validate a charity' do
    should '' do
      stub_post('/v1/charity/authenticate').with(:headers => {'Accept'=>'application/json'}).to_return(
        :body => fixture('charity_auth_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      auth = JustGiving::Charity.new.validate({:username => "MyCharityUsername",
        :password => "MyPassword", :pin => "MyPin"})
      assert auth["isValid"]
      assert !auth["error"]
      assert_equal 1235, auth["charityId"]
    end
  end
end