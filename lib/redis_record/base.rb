require 'redis'
require 'pry-rails'

# BASE
require 'redis_record/connection'
require 'redis_record/fields'
require 'redis_record/types'
require 'redis_record/queries'
require 'redis_record/key'
require 'redis_record/actions'
require 'redis_record/validations'
require 'redis_record/helpers'
require 'redis_record/associations'

# EXTENSIONS -> TODO
# require 'redis_record/extensions/timestamps'
# require 'redis_record/extensions/tree'
# require 'redis_record/extensions/orderable'
# require 'redis_record/extensions/paranoid'

module RedisRecord
  class Base
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml

    extend Connection
    extend Fields
    extend Types
    extend Queries
    extend Key

    include Actions
    include Validations
    include Helpers
    include Associations
  end
end
