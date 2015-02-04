# Copyright 2014 Penlook Development Team. All rights reserved.
# Use of this source code is governed by
# license that can be found in the LICENSE file.
# Author : Loi Nguyen <loint@penlook.com>

require 'redis'
require 'json'

class AwsConfig

	def initialize
		@redis = Redis.new
	end

	def get(name)
		config = @redis.get("aws.yml")
		return JSON.parse(config)
	end

end
