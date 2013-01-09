module AnalyticsExtension
  module AfterFilter
    extend ActiveSupport::Concern

    included do
      append_after_filter :analytics_extension_after_track_usage
    end
    
    def analytics_extension_after_track_usage
      action = params[:action]
      ret = ::AnalyticsExtension::Utility.parse_url_path(params[:controller])
      ::AnalyticsExtension::Usage.event(:api_controller_access, {action: action, filter: "after", api_version: ret[:api_version], object_definition_name: ret[:object_definition_name], response_code: response.code})
    end
  
  end
end