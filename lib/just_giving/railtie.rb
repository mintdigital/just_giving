require 'just_giving/view_helpers'
module JustGiving
  class Railtie < Rails::Railtie
    initializer "just_giving.view_helpers" do
      ActionView::Base.send :include, JustGiving::ViewHelpers
    end
  end
end
