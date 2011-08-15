require 'faraday'

module Faraday
  class Response::RaiseHttp4xx < Response::Middleware
    def on_complete(env)
      env[:response].on_complete do |response|
        case response[:status].to_i
        when 400
          raise JustGiving::BadRequest, error_message(response)
        when 404
          raise JustGiving::NotFound, error_message(response)
        end
      end
    end
    
    private

    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}"
    end
  end
end