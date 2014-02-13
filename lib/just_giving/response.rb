module JustGiving
  class Response
    attr_accessor :errors
    def initialize(errors)
      @errors = []
      errors.each{|e| @errors << Hashie::Mash.new(e)}
    end

    def any?
      errors.any?
    end

    def [](key)
      if respond_to?(key.to_sym)
        send(key.to_sym)
      else
        nil
      end
    end
  end
end
