# Copyright 2014 Penlook Development Team. All rights reserved.
# Use of this source code is governed by
# license that can be found in the LICENSE file.
# Author : Loi Nguyen <loint@penlook.com>

require './aws/config'

class AwsEC2

	# Amazon EC2 Initialize
	def initialize
		config = AwsConfig.new
		@aws = config.get('aws.yml')['access_key']
		@ec2 = AWS::EC2.new(
			region: 'us-west-2',
			access_key_id: @aws['key_id'],
  			secret_access_key: @aws['key_secret']
		)
	end

	# Command-line Interface
	def cmd(args)
		print args
	end

	# List all instances
	#
	# $penlook server list
	def list
		print "----------------- LIST INSTANCES -----------------\n"
		@ec2.instances.inject({}) { |m, instance|
			if instance.status then
				print instance.id, ' -- ', instance.instance_type, ' -- ', instance.status, ' -- ', instance.ip_address,"\n"
			end
		}
		print "--------------------------------------------------\n\n"
	end

	# Start single instance
	#
	# $penlook server start <instance_id>
	def start
		@ec2
	end

	# Stop single instance
	#
	# $penlook server stop <instance_id>
	def stop
		# TODO
	end

	# SSH to instance
	#
	# $penlook server ssh <instance_id>
	def ssh
		# TODO
	end

	def help
		puts "Usage: penlook server instance <parameter> <instance_id>"
   		puts "Parameters:"
    	puts "   list    List all instance available (not require <instance_id>)"
    	puts "   start   Start an instance"
    	puts "   stop    Stop an instance"
    	puts "   status  Status of instance"
    	puts "   ssh     SSH to an instance"
	end

end
