#!/usr/bin/env jruby
#.hashdot.profile += jruby-shortlived

#--
# Copyright (c) 2012 David Kellum
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License.  You
# may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.  See the License for the specific language governing
# permissions and limitations under the License.
#++

require 'rubygems'
require 'bundler/setup'

require 'minitest/unit'
require 'minitest/autorun'

require 'ji-tests'

class TestExceptionRunner < MiniTest::Unit::TestCase
  import 'jitests.ExceptionRunner'

  def test_noop
    runner = ExceptionRunner.new
    did_run = false
    runner.do_it_threaded do
      did_run = true
    end
    assert( did_run )
  end

  def test_direct_raise
    assert_raises( RuntimeError ) do
      raise "from ruby with love"
    end
  end

  def test_raise_now
    runner = ExceptionRunner.new

    assert_raises( RuntimeError ) do
      runner.do_it_now do
        raise "from ruby with love"
      end
    end

  end

  def test_raise_threaded
    runner = ExceptionRunner.new

    assert_raises( RuntimeError ) do
      runner.do_it_threaded do
        raise "from ruby with love"
      end
    end

  end

  def test_all_ruby_threaded
    runner = RubyRunner.new

    assert_raises( RuntimeError ) do
      runner.do_it_threaded do
        raise "from ruby with love"
      end
    end
  end

  class RubyRunner
    def do_it_threaded
      ex = nil
      t = Thread.new do
        begin
          yield
        rescue RuntimeError => e
          ex = e
        end
      end
      t.join
      raise ex if ex
    end
  end

end
