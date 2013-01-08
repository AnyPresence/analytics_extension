# Worker file for extension.
class LifecycleTriggeredAnalyticsExtension
  @queue = :analytics_extension
  
  # Perform asynchronous task.
  # Parameters:
  #   +klass_data+:: hash of options: 
  #    :interval, interval to run task
  #    :data, array of hashes, e.g. {:object_klazz => "Outage", :query_scope => "exact_match", :query_params => {}, :extension_method_name => "web_service_perform", :options_for_extension => {}} 
  def self.perform(klass_data) 
     AP::AnalyticsExtension::Analytics.analytics_perform(klass_data) 
  end
  
end