Rails.application.routes.draw do

  mount AnalyticsExtension::Engine => "/analytics_extension"
end
