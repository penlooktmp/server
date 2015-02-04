require 'redis'
require 'json'
#require 'aws-sdk'

class PenlookConfig

	def initialize
		@redis = Redis.new
	end

	def get(name)
		config = @redis.get("aws.yml")
		return JSON.parse(config)
	end

end
