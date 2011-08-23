module JustGiving
  class Response
    attr_accessor :errors
    def initialize(errors)
      @errors = []
      errors.each{|e| @errors << Hashie::Mash.new(e)}
    end
  end
end
