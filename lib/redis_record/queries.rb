module RedisRecord
  module Queries
    def all
      redis.scan_each(match: "#{name}:*").map do |key|
        find(key.split(':').last)
      end
    end

    def find(id)
      redis.exists(key(id)) ? new(normalize_hash(redis.hgetall(key(id)))) : nil
    end

    def find_by(atr, value)
      all.detect { |e| e.send(atr) == value.to_s }
    end

    def destroy_all
      all.each(&:destroy).size
    end

    private

    # Convert all strings keys in hash to symbols
    def normalize_hash(hash)
      Hash[hash.map{ |k, v| [k.to_sym, v] }]
    end
  end
end
