AnalyticsExtension::Engine.routes.draw do
  get 'settings' => 'analytics#index'
  post 'last_metric' => 'analytics#last_metric'
  post 'regenerate' => 'analytics#regenerate'
  
  root :to => "analytics#index"
end
