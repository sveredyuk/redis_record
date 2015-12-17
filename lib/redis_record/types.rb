module RedisRecord
  module Types

    def set_type(name, type)
      @types = redis.hgetall("#{self}Types")
      @types.merge!(name => type)
      redis.mapped_hmset("#{self}Types", @types)
    end

    def types
      normalize_hash(@types)
    end
  end
end

# Support data types:
# String
# Integer
# Float

# TODO -> Add more types for support
# Boolean
# Array
# Hash
