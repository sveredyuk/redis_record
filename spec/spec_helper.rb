require 'bundler/setup'
require File.expand_path("../../test/dummy/config/environment", __FILE__)
Bundler.setup

require 'rspec/rails'
require 'factory_girl'

Dir[Rails.root.join("spec/factories/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryGirl::Syntax::Methods
end
