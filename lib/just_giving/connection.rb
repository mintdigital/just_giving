require 'faraday_middleware'
require 'faraday/raise_http_4xx'

module JustGiving
  module Connection
    private
    
    def connection
      options = {
        :headers => {'Accept' => "application/xml"},
        :url => JustGiving::Configuration.api_endpoint,
        :ssl => {:ca_path => JustGiving::Configuration.ca_path, :verify => false}
      }

      Faraday::Connection.new(options) do |connection|
        connection.use Faraday::Request::UrlEncoded
        connection.use Faraday::Adapter::NetHttp
        connection.use Faraday::Response::ParseXml
        # connection.use Faraday::Response::RaiseHttp5xx
        connection.use Faraday::Response::RaiseHttp4xx
        connection.use Faraday::Response::Mashify
      end
    end
  end
end