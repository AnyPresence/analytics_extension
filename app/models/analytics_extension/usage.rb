module AnalyticsExtension
  # This class represents a the usage of the api.
  class Usage
    include ActiveModel::MassAssignmentSecurity
    include Mongoid::Document
    include Mongoid::Timestamps
    
    scope :with_date_range, lambda {|start_date, end_date| between(:created_at => start_date..end_date)}
    scope :with_date, lambda {|date| between(:created_at => date..(date+1.day))}
    scope :with_name, lambda {|name| where(:name => name)}
    scope :with_api_version, lambda {|version| where("value.api_version" => version)}
    scope :with_date_and_time, lambda {|date_time_hour| between(:created_at => (date_time_hour-30.minutes)..(date_time_hour+30.minutes)) }
    
    field :name, type: String
    field :value, type: Hash
    
    def self.event(name, value)
      begin
        ::AnalyticsExtension::Usage.create(name: name, value: value)
      rescue
        Rails.logger.error("Unable to create event: #{$!.message}")
      end
    end
    
    # Computes usage by hour for a +date+.
    #
    # Returns a hash where the keys are the time and values are the number of +Usage+ objects 
    # with +created_at+ time happening within 30 minutes of the hour, e.g. 13:30 - 14:30 is for the hour 14.
    def self.compute_hourly_usage_for_date(date, options={})
      stats = {}
      hour = date.to_time
      end_date = date.to_time+24.hours
      while hour < end_date
        usages = with_date_and_time(hour)
        usages = usages.with_name(options[:name]) unless options[:name].blank?
        usages = usages.with_api_version(options[:api_version]) unless options[:api_version].blank?
        stats[hour] = usages.count
        hour += 1.hour
      end
      stats
    end
    
    # Computes usage day for a date range.
    def self.compute_daily_usage_for_range(start_date, end_date, options={})
      stats = {}
      (start_date.to_date..end_date.to_date).each do |day|
        usages = with_date(day)
        usages = usages.with_name(options[:name]) unless options[:name].blank?
        usages = usages.with_api_version(options[:api_version]) unless options[:api_version].blank?
        stats[day] = usages.count
      end
      stats
    end
    
    # Computes the monthly usage for a date range
    def self.compute_monthly_usage_for_range(start_date, end_date, options={})
      stats = {}
      start_month = start_date.beginning_of_month
      month = start_month
      while month < end_date
        usages = with_date_range(month, month + 1.month)
        usages = usages.with_name(options[:name]) unless options[:name].blank?
        usages = usages.with_api_version(options[:api_version]) unless options[:api_version].blank?
        stats[month] = usages.count
        month += 1.month
      end
      stats
    end
    
  end
end