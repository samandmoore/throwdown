require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'data_mapper'
require 'dm-migrations'
Bundler.require

class Application < Sinatra::Base
	register Sinatra::Flash

	puts "=> app is running in #{settings.environment} env"

	# db configuration
	DataMapper::Logger.new($stdout, :debug)
	DataMapper.setup(:default, "sqlite://#{Dir.pwd}/throwdown.db")

	# enable :sessions

	# libs
	# require File.dirname(__FILE__) + '/lib/global.rb'

	# models, require all models
	Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| 
		require file
	}

	# models loaded, finalize db
	DataMapper.finalize
	DataMapper.auto_migrate!

	# routes, require all controllers
	Dir[File.dirname(__FILE__) + '/controllers/*.rb'].each { |file| 
		require file
	}

	# explicitly setup public director for serving static files, optional
	set :public_folder, File.dirname(__FILE__) + '/public'
end