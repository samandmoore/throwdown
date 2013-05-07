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
		puts "Bootstrapping database (destroys data)..."
		
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
		puts "Upgrading database (preserves data)..."

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
		puts "Populating the database with default data"

		universe = Universe.first_or_create(
			:name => 'Default'
		)

		[{:name => 'Josie', :image_url => '/images/josie.jpg'},
		{:name => 'Kacie', :image_url => '/images/kacie.jpg'},
		{:name => 'Tucker', :image_url => '/images/tucker.jpg'},
		{:name => 'Scout', :image_url => '/images/scout.jpg'}].each do |noun|
			Noun.first_or_create(
				:name => noun[:name],
				:image_url => noun[:image_url],
				:image_src => :local,
				:universe => universe
			)
		end

		['Brown', 'Blue', 'Black', 'White', 'Red'].each do |adj|
			Adjective.first_or_create(
				:name => adj,
				:universe => universe
			)
		end
	end
end

namespace :imports do
	desc 'Import some data from flickr'
	task :data_from_flickr => ['db:upgrade'] do
		require File.dirname(__FILE__) + '/../lib/flickr_import'

		puts "Starting import from Flickr"
		flickr_importer = FlickrImport.new()
		results = flickr_importer.run()
		puts "Imported from Flickr #{} adjectives, #{} nouns"
	end
end