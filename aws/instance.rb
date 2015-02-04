# Copyright 2014 Penlook Development Team. All rights reserved.
# Use of this source code is governed by
# license that can be found in the LICENSE file.
# Author : Loi Nguyen <loint@penlook.com>

require './aws/config'
require 'net/ssh'

class AwsEC2

	# Amazon EC2 Initialize
	def initialize
		@config = AwsConfig.new
		@aws = @config.get('aws.yml')['access_key']
		@ec2 = AWS::EC2.new(
			region: 'us-west-2',
			access_key_id: @aws['key_id'],
  			secret_access_key: @aws['key_secret']
		)
	end

	# Command-line Interface
	def cmd(args)

		if respond_to?(args[0])
		then
			eval("#{args[0]}(\"#{args[1]}\")")
		else
			help
		end

	end

	# List all instances
	#
	# $penlook server list
	def list(id = nil)

		print "----------------- LIST INSTANCES -----------------\n"
		@ec2.instances.inject({}) { |m, instance|
			if instance.status then
				print instance.id, ' -- ', instance.instance_type, ' -- ', instance.status, ' -- ', instance.ip_address, "\n"
			end
		}
		print "--------------------------------------------------\n\n"

	end

	# Start single instance
	#
	# $penlook server start <instance_id>
	def start(id)
		puts "Start instance : #{id}"
	end

	# Stop single instance
	#
	# $penlook server stop <instance_id>
	def stop(id)
		puts "Stop instance : #{id}"
	end

	# SSH to instance
	#
	# $penlook server ssh <instance_id>
	def ssh(id)
		require(id)
		puts "SSH to instance : #{id}"
		instance = @ec2.instances[id]
		ip = instance.ip_address
		if ip then
			pem = @config.key('aws.pem')
			system('ssh -i ' + pem + ' ec2-user@' + ip)
		else
			puts "Instance #{id} is not ready !"
		end
	end

	def require(id)
		if defined?(id) && (id != '')
		then
		else
			help
			exit(true)
		end
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
