# Copyright 2014 Penlook Development Team. All rights reserved.
# Use of this source code is governed by
# license that can be found in the LICENSE file.
# Author : Loi Nguyen <loint@penlook.com>

require './aws/config'

class AwsS3

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
