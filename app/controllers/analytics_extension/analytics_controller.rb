require_dependency "analytics_extension/application_controller"

module AnalyticsExtension
  class AnalyticsController < ApplicationController
    
    def index
      # Default start and end time
      @start_date = Time.now - 1.week
      @end_date = Time.now
    end
    
    def statistics
      mode = params[:mode] || :per_day
      start_date = params[:start_date] 
      end_date = params[:end_date]
      
      case mode.to_sym
      when :per_hour
        usages = ::AnalyticsExtension::Usage.compute_hourly_usage_for_date(params[:name], start_date)
      when :per_day
        usages = ::AnalyticsExtension::Usage.compute_daily_usage_for_range(params[:name], start_date, end_date)
      when :per_month
        usages = ::AnalyticsExtension::Usage.compute_monthly_usage_for_range(params[:name], start_date, end_date)
      when :per_year
        usages = ::AnalyticsExtension::Usage.compute_monthly_usage_for_range(params[:name], start_date, end_date)
      end
      
      ::AnalyticsExtension::Metric.create(name: mode, independent_values: usages.keys, dependent_values: usages.values)
     
      render :json => usages
    end
    
  end
end
