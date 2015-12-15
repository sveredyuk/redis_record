module RedisRecord
  module Queries
    def all
      redis.scan_each(match: "#{name}:*").map do |key|
        find(key.split(':').last)
      end
    end

    def find(id)
      redis.exists(key(id)) ? new(redis.hgetall(key(id))) : nil
    end

    def find_by(atr, value)
      all.detect { |e| e.send(atr) == value.to_s }
    end

    def destroy_all
      all.each(&:destroy)
    end
  end
end
