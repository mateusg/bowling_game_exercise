if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start { add_filter 'spec' }
end

require 'bundler/setup'
require 'bowling_game'
