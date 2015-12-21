$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "redis_record/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "redis_record"
  s.version     = RedisRecord::VERSION
  s.authors     = ["Volodya Sveredyuk"]
  s.email       = ["sveredyuk@gmail.com"]
  s.homepage    = "http://github.com/..."
  s.summary     = "RedisRecord"
  s.description = "ORM for Redis & Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency 'redis'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'better_errors'
  s.add_development_dependency 'binding_of_caller'
  s.add_development_dependency 'responders', '~> 2.0'
end
