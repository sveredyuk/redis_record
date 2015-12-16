module RedisRecord
  module Key
    def key(id)
      "#{name}:#{id}"
    end
  end
end
