require 'faraday'
require 'multi_json'

module Faraday
  class Response::RaiseHttp5xx < Response::Middleware
    def on_complete(env)
      env[:response].on_complete do |response|
        case response[:status].to_i
        when 500
          raise JustGiving::InternalServerError, error_message(response)
        end
      end
    end
    
    private

    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]} #{error_body(response[:body])}"
    end
    
    def error_body(body)
      if body.nil?
        nil
      elsif body['error']
        body['error']['id']
      end
    end
  end
end
