$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'webmock/rspec'

require 'fluent/test'
require 'fluent/mixin/ec2meta_placeholders'

# Disable Test::Unit
module Test::Unit::RunCount; def run(*); end; end

unless ENV.key?('VERBOSE')
  nulllogger = Object.new
  nulllogger.instance_eval do |_obj|
    def method_missing(_method, *_args)
      # pass
    end
  end
  $log = nulllogger
end

path = Pathname.new(Dir.pwd)
Dir[path.join('spec/support/**/*.rb')].map { |f| require f }

RSpec.configure do |config|
  config.before(:all) do
    Fluent::Test.setup
  end
  config.order = :random
  Kernel.srand config.seed
end
