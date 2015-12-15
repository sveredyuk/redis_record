module RedisRecord
  module Actions
    attr_writer :redis

    def initialize(params = {})
      @fields = Hash[self.class.fields.map { |k| [normalize_key(k), nil] }]
      @fields.merge!(params)
    end

    def save
      return false unless valid?

      redis.mapped_hmset(self.class.key(id), @fields)
      true
    rescue
      false
    end

    def save!
      return false unless valid?

      redis.mapped_hmset(self.class.key(id), @fields)
      true
    end

    def update(hash)
      hash.each do |key, val|
        @fields[normalize_key(key)] = normalize_value(val)
      end
      save
    end

    def destroy
      redis.del(key)
    end
  end
end
