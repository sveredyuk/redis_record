module RedisRecord
  module Connection
    attr_writer :redis

    def redis
      @redis ||= Redis.new
    end
  end
end
