require 'faraday'

module Faraday
  class Response::RaiseHttp4xx < Response::Middleware
    def on_complete(env)
      env[:response].on_complete do |response|
        case response[:status].to_i
        when 404
          raise JustGiving::NotFound, error_message(response)
        end
      end
    end
    
    private

    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]} #{error_body(response[:body])}"
    end

    def error_body(body)
      body = MultiJson.decode(body)
      if body.nil?
        nil
      elsif body.any?
        body.collect{|error| "#{error['id']} #{error['desc']}"}
      end
    end
  end
end
