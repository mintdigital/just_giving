module JustGiving
  module Request
    def get(path, options={})
      request(:get, path, options)
    end
    
    private
    
    def request(method, path, options)
      response = connection.send(method) do |request|
        case method.to_sym
        when :get, :delete
          request.url(path, options)
        # when :post, :put
        #   request.path = formatted_path(path, format)
        #   request.body = options unless options.empty?
        end
      end
      response.body
    end
  end
end