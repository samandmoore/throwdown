require 'rubygems'
require 'bundler/setup'
Bundler.require

module Throwdown
	Root = File.dirname(__FILE__)
end

Dir["tasks/*.rake"].sort.each { |ext| load ext }

task :default => 'dev:start'