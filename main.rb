require 'redis'

redis = Redis.new
redis.set("tmp", "hello world")
print redis.get("tmp")