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
# |   Author: Loi Nguyen  <loint@penlook.com>                                |
# +--------------------------------------------------------------------------+

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
	"instance" => "AwsInstance",
	"storage"  => "AwsStorage"
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
