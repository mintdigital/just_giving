module JustGiving
  class Railtie < Rails::Railtie
    initializer "just_giving.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
