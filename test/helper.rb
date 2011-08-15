require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'webmock/test_unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'just_giving'

def stub_get(path)
  stub_request(:get, JustGiving::Configuration.api_endpoint + path)
end

def fixture(file)
  File.new(File.expand_path("../fixtures", __FILE__) + '/' + file)
end

class Test::Unit::TestCase
end
