module RedisRecord
  module Types
    attr_reader :types

    def set_type(name, type)
      @types = redis.hgetall("#{self}Types")
      @types.merge!(name => type)
      redis.mapped_hmset("#{self}Types", @types)
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
