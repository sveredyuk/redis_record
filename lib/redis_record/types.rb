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

  module Bool
    extend self

    TRUE  = 'true'
    FALSE = 'false'

    def convert(value)
      if [TRUE, true].include? value
        return true
      elsif [FALSE, false].include? value
        return false
      else
        nil
      end
    end
  end
end

class Bool; end


# Support data types:
# String
# Integer
# Float

# TODO -> Add more types for support
# Boolean
# Array
# Hash
