#!/usr/bin/env ruby
# Copyright 2014 Penlook Development Team. All rights reserved.
# Use of this source code is governed by
# license that can be found in the LICENSE file.
# Author : Loi Nguyen <loint@penlook.com>

require 'aws-sdk-v1'
require './aws/instance'

args = Array.new
ARGV.each do|a|
	args.push(a)
end

def help
	puts "Usage: penlook server <option> <parameter>"
   	puts "Options:"
    puts "   instance  EC2 instances"
    puts "   storage   S3 storages"
end

modules = Hash[
	"instance" => "AwsEC2",
	"storage"  => "AwsS3"
]

if args[0]
	if File.exist?("./aws/#{args[0]}.rb")
		obj = eval(modules[args[0]] + ".new")
		obj.cmd(args.slice(1, args.length()))
	else
		help
	end
else
	help
end

#ec2 = AwsEC2.new
#ec2.list()
