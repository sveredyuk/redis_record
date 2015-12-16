require 'redis_record/core/base'

class Post < RedisRecord::Base
  field :title
  fields :body, :author
end
