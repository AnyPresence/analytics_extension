class V1::Outage
  include Mongoid::Document
  include Mongoid::Timestamps
  include ::AP::AnalyticsExtension::Analytics
  
  after_save :__analytics_on_save_perform
  
  field :"title", type: String
  
  def __analytics_on_save_perform
    analytics_perform(self, {action: "save"})
  end
  
end