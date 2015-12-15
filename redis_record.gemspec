$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "redis_record/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "redis_record"
  s.version     = RedisRecord::VERSION
  s.authors     = ["Volodya Sveredyuk"]
  s.email       = ["sveredyuk@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RedisRecord."
  s.description = "TODO: Description of RedisRecord."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_development_dependency "sqlite3"
end
