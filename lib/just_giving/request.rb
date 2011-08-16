module JustGiving
  module Request
    def get(path, options={})
      request(:get, path, options)
    end

    def put(path, options={})
      request(:put, path, options)
    end

    def head(path, options={})
      request(:head, path, options)
    end

    def post(path, options={})
      request(:post, path, options)
    end
    
    private
    
    def request(method, path, options)
      basic_auth = options.delete(:basic_auth)
      response = connection(basic_auth).send(method) do |request|
        case method.to_sym
        when :get, :head
          request.url(path, options)
        when :put, :post
          request.path = path
          request.body = options unless options.empty?
        end
      end
      response.body
    end
  end
end