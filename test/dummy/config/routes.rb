Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do  
      resources :outages
    end
  end
  
  mount AnalyticsExtension::Engine => "/analytics_extension"
  
  
end
