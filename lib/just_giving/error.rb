module JustGiving
  class Error < StandardError; end
  
  class BadRequest < Error; end
  
  class NotFound < Error; end
end