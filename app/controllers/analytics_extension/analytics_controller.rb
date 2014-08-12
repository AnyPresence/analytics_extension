require_dependency "analytics_extension/application_controller"

module AnalyticsExtension
  class AnalyticsController < ApplicationController

    def index
      # Default start and end time
      @start_date = Time.now - 1.week
      @end_date = Time.now

      @api_versions = ::AnalyticsExtension::Usage.all.distinct("value.api_version").select{|m| !m.blank?} || ["v1"]

      # Try some sorting
      begin
        @api_versions.sort! do |a,b|
          ver_a = a.match(/v(\d+)/).captures.first.to_i
          ver_b = b.match(/v(\d+)/).captures.first.to_i

          ver_a < ver_b ? -1 : (ver_a > ver_b ? 1 : (ver_a <=> ver_b))
        end
      rescue
        # ignore
      end

      # Look for existing metric
      @metric = ::AnalyticsExtension::Metric.last
    end

    def regenerate
      mode = params[:mode] || :per_day
      @start_date = Date.strptime(params[:start_date], '%m/%d/%Y')
      @end_date = Date.strptime(params[:end_date], '%m/%d/%Y')
      chosen_api_version = params[:api_version]
      options = {}
      options[:api_version] = params[:api_version] unless params[:api_version].blank?

      usages = compute(mode, @start_date, @end_date, options)

      render :json => usages
    end

    def last_metric
      mode = params[:mode] || :per_day
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      chosen_api_versions = params[:api_versions]

      usages = {}
      if mode.to_sym == :computed_metric
        computed_metric = ::AnalyticsExtension::Metric.last

        computed_metric.independent_values.each_with_index do |time, idx|
          usages[time] = computed_metric.dependent_values[idx]
        end
      end

      render :json => usages
    end

  protected

    def compute(mode, start_date, end_date, options={})
      case mode.to_sym
      when :per_hour
        usages = ::AnalyticsExtension::Usage.compute_hourly_usage_for_date(start_date, options)
      when :per_day
        usages = ::AnalyticsExtension::Usage.compute_daily_usage_for_range(start_date, end_date, options)
      when :per_month
        usages = ::AnalyticsExtension::Usage.compute_monthly_usage_for_range(start_date, end_date, options)
      when :per_year
        usages = ::AnalyticsExtension::Usage.compute_monthly_usage_for_range(start_date, end_date, options)
      else
        usages = {}
      end

      ::AnalyticsExtension::Metric.create(name: mode, independent_values: usages.keys, dependent_values: usages.values) if !usages.blank?
      usages
    end

  end
end
