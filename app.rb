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

	# models, require all models
	Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| 
		require file
	}

	# routes, require all controllers
	Dir[File.dirname(__FILE__) + '/controllers/*.rb'].each { |file| 
		require file
	}

	# explicitly setup public director for serving static files, optional
	set :public_folder, File.dirname(__FILE__) + '/public'
end