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

    def fields
      @fields.dup
    end

    def find_by(atr, value)
      self.class.find_by(atr, value)
    end

    private

    def key
      self.class.key(id)
    end

    def normalize_key(key)
      key.to_sym
    end

    def normalize_value(value)
      value.to_s
    end
  end
end
