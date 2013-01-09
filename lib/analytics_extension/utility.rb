module AnalyticsExtension
  class Utility
    
    def self.parse_url_path(str)
      ret = {}
      if str =~ /api\/(v.+?)\/([^\/]+)/
        ret[:api_version] = $1
        ret[:object_definition_name] = $2.singularize
      end
      ret
    end
    
  end
end