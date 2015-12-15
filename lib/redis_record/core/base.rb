require 'redis'
require 'pry-rails'

require 'redis_record/core/connection'
require 'redis_record/core/fields'
require 'redis_record/core/queries'
require 'redis_record/core/key'
require 'redis_record/core/actions'
require 'redis_record/core/validations'
require 'redis_record/core/helpers'
require 'redis_record/core/associations'

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
