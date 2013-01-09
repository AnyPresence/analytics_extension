module AnalyticsExtension
  module BeforeFilter
    extend ActiveSupport::Concern

    included do
      append_before_filter :analytics_extension_before_track_usage
    end
    
    def analytics_extension_before_track_usage
      action = params[:action]
      ret = ::AnalyticsExtension::Utility.parse_url_path(params[:controller])
      ::AnalyticsExtension::Usage.event(:api_controller_access, {action: action, filter: "before", api_version: ret[:api_version], object_definition_name: ret[:object_definition_name]})
    end
  
  end
end