require 'rubygems'
require 'bundler/setup'
Bundler.require

class Application < Sinatra::Base
	register Sinatra::Flash
	register Sinatra::ConfigFile

	config_file "#{Dir.pwd}/config.yml"

	puts "=> app is running in #{settings.environment} env"

	enable :sessions

	# explicitly setup public directory for serving static files, optional
	set :public_folder, File.dirname(__FILE__) + '/public'

	configure :development do
		Bundler.require(:development)
		DataMapper::Logger.new($stdout, :debug)
		DataMapper.setup(:default, "sqlite://#{Dir.pwd}/#{settings.db_name}.db")
		DataMapper::Model.raise_on_save_failure = true
	end

	configure :production do
		Bundler.require(:production)
		DataMapper.setup(:default, ENV['DATABASE_URL'])
	end

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
end