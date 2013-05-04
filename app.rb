require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
Bundler.require

class Application < Sinatra::Base
	register Sinatra::Flash

	puts "=> app is running in #{settings.environment} env"

	# enable :sessions

	# libs
	# require File.dirname(__FILE__) + '/lib/global.rb'
	require File.dirname(__FILE__) + '/models/noun.rb'

	# routes
	require File.dirname(__FILE__) + '/controllers/root.rb'

	# explicitly setup public director for serving static files, optional
	set :public_folder, File.dirname(__FILE__) + '/public'
end