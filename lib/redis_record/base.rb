require 'redis'
require 'pry-rails'

# BASE
require 'redis_record/connection'
require 'redis_record/fields'
require 'redis_record/queries'
require 'redis_record/key'
require 'redis_record/actions'
require 'redis_record/validations'
require 'redis_record/helpers'
require 'redis_record/associations'

# EXTENSIONS
# require 'redis_record/extensions/timestamps'

module RedisRecord
  class Base
    include ActiveModel::Model

    extend Connection
    extend Fields
    extend Queries
    extend Key

    include Actions
    include Validations
    include Helpers
    include Associations
  end
end
