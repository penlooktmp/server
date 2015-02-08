#!/usr/bin/env ruby
# +--------------------------------------------------------------------------+
# | Penlook Project                                                          |
# +--------------------------------------------------------------------------+
# | Copyright (c) 2015 Penlook Development Team                              |
# +--------------------------------------------------------------------------+
# |                                                                          |
# | This program is free software: you can redistribute it and/or modify     |
# | it under the terms of the GNU Affero General Public License as           |
# | published by the Free Software Foundation, either version 3 of the       |
# | License, or (at your option) any later version.                          |
# |                                                                          |
# | This program is distributed in the hope that it will be useful, but	     |
# | WITHOUT ANY WARRANTY; without even the implied warranty of               |
# | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            |
# | GNU Affero General Public License for more details.                      |
# |                                                                          |
# | You should have received a copy of the GNU Affero General Public License |
# | along with this program.  If not, see <http://www.gnu.org/licenses/>.    |
# |                                                                          |
# +--------------------------------------------------------------------------+
# |   Author:                                                                |
# |         Loi Nguyen <loint@penlook.com>                                   |
# +--------------------------------------------------------------------------+

require 'redis'
require 'json'

class AwsConfig

	def initialize
		@redis = Redis.new
	end

	def set(key, value)
		@redis.set(key, value)
		return self
	end

	def get(key)
		return @redis.get(key)
	end

	def file(file_name)
		config = @redis.get(file_name)
		return JSON.parse(config)
	end

	def cmd
		help
	end

end
