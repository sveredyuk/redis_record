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

    module Converter
      extend self

      def convert(value, type)
        if type.to_s == 'String'
          value.to_s

        elsif type.to_s == 'Integer'
          value.to_i

        elsif type.to_s == 'Float'
          value.to_f

        elsif type.to_s == 'Bool'
          Bool.convert(value)

        elsif type.to_s == 'Array'
        begin
          return value if value && value.instance_of?(Array)
          JSON.parse(value)
        rescue
          nil
        end

        elsif type.to_s == 'Hash'
          return value if value && value.instance_of?(Hash)
        begin
          JSON.parse(value)
        rescue
          nil
        end

        elsif type.to_s == 'Time'
          return value if value && value.instance_of?(Time)
        begin
          DateTime.parse(value)
        rescue
          nil
        end

        else
          value.to_s
        end
      end
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
# Boolean
# Array
# Hash
# DateTime
