require 'singleton'

module AP
  module AnalyticsExtension
    module Analytics
      # Creates the account.
      # +config+ configuration properties should contain
      def self.config_account(config={})
        config = HashWithIndifferentAccess.new(config)
        Config.instance.configuration ||= HashWithIndifferentAccess.new
        Config.instance.configuration = Config.instance.configuration.merge(config)
      end
      
      def analytics_perform(object_instance, options={})
        options = HashWithIndifferentAccess.new(options)
        ::AnalyticsExtension::Usage.event(:api_crud, {action: options[:action], object_defintion: object_instance.class.name})
      end
      
      class Config
        include Singleton
        
        attr_accessor :configuration
      end
    end
  end
end