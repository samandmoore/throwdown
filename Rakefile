require 'rubygems'
require 'bundler/setup'
Bundler.require

# Development server management
namespace :dev do
	desc 'Start in development mode'
	task :start => ['db:populate'] do
		system 'rackup -p 1234'
	end
end

namespace :db do
	desc 'Auto-migrate the database (destroys data)'
	task :migrate do
		puts "Bootstrapping database (destroys data)...".yellow
		
		Bundler.require(:development)
		DataMapper::Logger.new($stdout, :debug)
		DataMapper.setup(:default, "sqlite://#{Dir.pwd}/throwdown.db")
		DataMapper::Model.raise_on_save_failure = true

		# models, require all models
		Dir[File.dirname(__FILE__) + '/models/*.rb'].each do |file|
			require file
		end

		DataMapper.finalize
		DataMapper.auto_migrate!
	end

	desc 'Auto-upgrade the database (preserves data)'
	task :upgrade do
		puts "Upgrading database (preserves data)...".yellow

		Bundler.require(:development)
		DataMapper::Logger.new($stdout, :debug)
		DataMapper.setup(:default, "sqlite://#{Dir.pwd}/throwdown.db")
		DataMapper::Model.raise_on_save_failure = true

		# models, require all models
		Dir[File.dirname(__FILE__) + '/models/*.rb'].each do |file|
			require file
		end

		DataMapper.finalize
		DataMapper.auto_upgrade!
	end

	desc 'Populate the database with default data'
	task :populate => [:upgrade] do
		require File.dirname(__FILE__) + '/lib/db_import'

		puts "Populating the database with default data".yellow

		db_importer = DbImport.new()
		db_importer.run()

		puts "Imported nouns and adjectives into database".green
	end
end

namespace :imports do
	desc 'Import some data from flickr'
	task :data_from_flickr => ['db:upgrade'] do
		require File.dirname(__FILE__) + '/lib/flickr_import'

		puts "Starting import from Flickr".yellow
		
		flickr_importer = FlickrImport.new()
		results = flickr_importer.run()
		
		puts "Imported from Flickr #{} adjectives, #{} nouns".green
	end
end