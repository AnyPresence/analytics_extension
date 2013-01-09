module AnalyticsExtension
  class Engine < ::Rails::Engine
    isolate_namespace AnalyticsExtension
    
    initializer "analytics.load_filters" do
      ActionController::Base.send(:include, ::AnalyticsExtension::BeforeFilter)
      ActionController::Base.send(:include, ::AnalyticsExtension::AfterFilter)
    end
    
  end
end
