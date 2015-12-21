module RedisRecord
  module Helpers
    def redis
      @redis ||= self.class.redis
    end

    def id
      @fields[:id] ||= SecureRandom.hex(10)
    end

    def persisted?
      find_by(:id, id)
    end

    def to_param
      persisted? ? id : nil
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
  end
end
