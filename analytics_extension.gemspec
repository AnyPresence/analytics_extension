$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "analytics_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "analytics_extension"
  s.version     = AnalyticsExtension::VERSION
  s.authors     = ["Anypresence"]
  s.email       = ["info@anypresence.com"]
  s.homepage    = "http://www.anypresence.com/"
  s.summary     = ""
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.add_dependency "rails", "~> 3.2.9"
  s.add_dependency "mongoid", "~> 3.0.6"

  s.add_development_dependency "debugger"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl", "= 3.3.0"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "mocha", "~> 0.12.3"

end
