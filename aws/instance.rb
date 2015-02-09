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

require 'aws-sdk-v1'
require 'json'
require_relative './config.rb'

class AwsInstance

	# Amazon EC2 Initialize
	def initialize

		@config = AwsConfig.new
		aws_file = @config.get('aws.yml')

		if aws_file == nil
			puts "Please use penlook config to initialize configuration."
			exit 1
		end

		cred_data = JSON.parse(aws_file)
		@aws = cred_data['access_key']
		@ec2 = AWS::EC2.new(
			region: 'us-west-2',
			access_key_id: @aws['key_id'],
  			secret_access_key: @aws['key_secret']
		)

		return self
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
	# $ penlook server list
	def list(id = nil)

		print "----------------- LIST INSTANCES -----------------\n"
		list_instance = Array.new

		@ec2.instances.inject({}) { |m, instance|
			list_instance.push(instance)
			if instance.status then
				print '| ', instance.id, ' | ', instance.instance_type, ' | ', instance.status, ' | ', instance.ip_address, "\n"
			end
		}
		print "--------------------------------------------------\n\n"

		return list_instance
	end

	# Start single instance
	#
	# $ penlook server start <instance_id>
	def start(id)
		require(id)
		puts "Start instance : #{id}"
	end

	# Stop single instance
	#
	# $ penlook server stop <instance_id>
	def stop(id)
		require(id)
		puts "Stop instance : #{id}"
	end

	# SSH to instance
	#
	# $ penlook server ssh <instance_id>
	def ssh(id)
		require(id)
		puts "SSH to instance : #{id}"
		instance = @ec2.instances[id]
		ip = instance.ip_address
		if ip then
			pem = @config.file('aws.pem')
			system('ssh -i ' + pem + ' ec2-user@' + ip)
		else
			puts "Instance #{id} is not ready !"
		end
	end

	# Reqire ID for single instance
	def require(id)
		if defined?(id) && (id != '')
		then
		else
			help
			exit(true)
		end
	end

	# Help for instance
	def help
		puts "Usage: penlook server <parameter> <instance_id>"
   		puts "Parameters:"
    	puts "   list    List all instance available (not require <instance_id>)"
    	puts "   start   Start an instance"
    	puts "   stop    Stop an instance"
    	puts "   status  Status of instance"
    	puts "   ssh     SSH to an instance"
	end

end
