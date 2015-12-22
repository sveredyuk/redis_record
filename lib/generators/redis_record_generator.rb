class RedisRecordGenerator < Rails::Generators::Base
  def create_redisrecord_file
    create_file "config/initializers/redis_record.rb", "RedisRecord::Config.namespace = 'RedisRecord_#{SecureRandom.hex(5)}'"
  end
end
