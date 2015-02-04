#!/usr/bin/env ruby
require 'aws-sdk-v1'
require './config'

ARGV.each do|a|
  puts "Argument: #{a}"
end

config = PenlookConfig.new
aws = config.get('aws.yml')
key = aws['access_key']

ec2 = AWS::EC2.new(
	region: 'us-west-2',
	access_key_id: key['key_id'],
  	secret_access_key: key['key_secret']
)

print ec2.instances.inject({}) { |m, instance|
	print instance.id + ' -- ' + instance.instance_type + "\n"
}


