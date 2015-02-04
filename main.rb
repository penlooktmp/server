#!/usr/bin/env ruby
# Copyright 2014 Penlook Development Team. All rights reserved.
# Use of this source code is governed by
# license that can be found in the LICENSE file.
# Author : Loi Nguyen <loint@penlook.com>

require 'aws-sdk-v1'
require './aws/instance'

ARGV.each do|a|
  puts "Argument: #{a}"
end

ec2 = AwsEC2.new
ec2.list()
