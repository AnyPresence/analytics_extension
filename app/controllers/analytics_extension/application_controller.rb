class AnalyticsExtension::ApplicationController < ApplicationController
  before_filter :authenticate_admin!
  layout "layouts/admin"
end
