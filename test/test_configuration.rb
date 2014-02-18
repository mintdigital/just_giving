require 'helper'

class TestConfiguration < Test::Unit::TestCase
  should 'allow setting/getting of application_id' do
    JustGiving::Configuration.application_id = '1234'
    assert_equal '1234', JustGiving::Configuration.application_id
    JustGiving::Configuration.application_id = '5678'
    assert_equal '5678', JustGiving::Configuration.application_id
  end
  
  should 'allow setting the enviroment' do
    assert_equal :staging, JustGiving::Configuration.environment
    JustGiving::Configuration.environment = :sandbox
    assert_equal :sandbox, JustGiving::Configuration.environment
    JustGiving::Configuration.environment = :production
    assert_equal :production, JustGiving::Configuration.environment
  end

  should 'return the base_uri based on environment' do
    JustGiving::Configuration::BASE_URI_MAP.each do |k,v|
      JustGiving::Configuration.environment = k
      assert_equal v, JustGiving::Configuration.base_uri
    end
  end
  
  should 'return the api endpoint' do
    JustGiving::Configuration.application_id = '5678'
    JustGiving::Configuration.environment = :sandbox
    assert_equal 'https://api-sandbox.justgiving.com/5678', JustGiving::Configuration.api_endpoint
    JustGiving::Configuration.environment = :staging
    assert_equal 'https://api-staging.justgiving.com/5678', JustGiving::Configuration.api_endpoint
    JustGiving::Configuration.environment = :production
    assert_equal 'https://api.justgiving.com/5678', JustGiving::Configuration.api_endpoint
  end
  
  should 'raise if application id is not set' do
    JustGiving::Configuration.application_id = nil
    assert_raise JustGiving::InvalidApplicationId do
      JustGiving::Configuration.api_endpoint
    end
  end

  should 'return the ca_path' do
    assert_equal '/usr/lib/ssl/certs', JustGiving::Configuration.ca_path
    JustGiving::Configuration.ca_path = '/System/Library/OpenSSL/certs'
    assert_equal '/System/Library/OpenSSL/certs', JustGiving::Configuration.ca_path
  end
end
