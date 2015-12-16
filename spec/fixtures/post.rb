require 'redis_record/base'

class Post < RedisRecord::Base
  field :title
  fields :body, :author
end
