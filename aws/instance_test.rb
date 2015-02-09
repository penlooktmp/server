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

require "test/unit"
require_relative "./instance.rb"

class TestAwsInstance < Test::Unit::TestCase

	def setup
		# Setup
		@instance = AwsInstance.new
	end

	def teardown
		# Teardown
	end

	def test_instance_list
		mockup
		list = @instance.list
		assert_equal(list.length, 3)
	end

	def test_instance_start

	end

	def test_instance_stop

	end

	def test_instance_ssh

	end

end