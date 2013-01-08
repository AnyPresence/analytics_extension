AnalyticsExtension::Engine.routes.draw do
  get 'settings' => 'analytics#index'
  get 'statistics' => 'analytics#statistics'
  
  root :to => "analytics#index"
end
