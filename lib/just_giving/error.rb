module JustGiving
  class Error < StandardError; end
  
  class BadRequest < Error; end
  
  class NotFound < Error; end

  class InternalServerError < Error; end

  class InvalidApplicationId < Error; end
end