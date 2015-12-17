module RedisRecord
  module Helpers
    def redis
      @redis ||= self.class.redis
    end

    def id
      @fields[:id] ||= SecureRandom.hex(10)
    end

    def persisted?
      false
    end

    def attributes
      @fields.dup
    end

    private

    def find_by(atr, value)
      self.class.find_by(atr, value)
    end

    def key
      self.class.key(id)
    end

    def normalize_key(key)
      key.to_sym
    end

    def normalize_value(value)
      value.to_s
    end

    def get_type(name)
      self.class.types[name.to_sym]
    end

    def convert_to_type(value, type)
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
        return value if value.present? && value.kind_of?(Array)
        JSON.parse(value)
      rescue
        nil
      end

      elsif type.to_s == 'Hash'
        return value if value.present? && value.kind_of?(Hash)
      begin
        JSON.parse(value)
      rescue
        nil
      end

      else
        value.to_s
      end
    end
  end
end
