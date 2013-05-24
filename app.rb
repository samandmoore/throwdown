require 'rubygems'
require 'bundler/setup'
Bundler.require

class Application < Sinatra::Base
	register Sinatra::Flash
	register Sinatra::ConfigFile

	config_file "#{Dir.pwd}/config.yml"

	puts "=> app is running in #{settings.environment} environment"

	enable :sessions

	# explicitly setup public directory for serving static files, optional
	set :public_folder, File.dirname(__FILE__) + '/public'

	# requires all models, routes, and database configuration
	require_relative 'lib/bootstrap'
	Throwdown::Bootstrapper.init(File.dirname(__FILE__))

	Paperclip.configure do |config|
		config.root = Dir.pwd
		config.env = ENV['RACK_ENV']
		config.use_dm_validations = true
		config.processors_path = 'lib/pc' # relative path to look for processors, defaults to 'lib/paperclip_processors'
	end
end