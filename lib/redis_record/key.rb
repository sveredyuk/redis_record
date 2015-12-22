module RedisRecord
  module Key
    def key(id)
      "#{namespace}:#{name}:#{id}"
    end
  end
end
