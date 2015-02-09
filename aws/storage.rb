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
# |   Authors: Loi Nguyen  <loint@penlook.com>                               |
# +--------------------------------------------------------------------------+

require './aws/config'

class AwsStorage

	def initialize
		config = AwsConfig.new
		@aws = config.get('aws.yml')['access_key']
		@s3 = AWS::S3.new(
			region: 'us-west-2',
			access_key_id: @aws['key_id'],
  			secret_access_key: @aws['key_secret']
		)
	end

	def list
		@ec2.instances.inject({}) { |m, instance|
			if instance.status then
				print instance.id + ' -- ' + instance.instance_type + ' -- ', instance.status, "\n"
			end
		}
	end

end
