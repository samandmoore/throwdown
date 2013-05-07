namespace :import do
	desc 'Import some data from flickr'
	task :flickr => ['db:upgrade', 'db:populate'] do
		require File.dirname(__FILE__) + '/lib/flickr_import'

		puts "Starting import from Flickr".yellow
		
		flickr_importer = FlickrImport.new()
		results = flickr_importer.run()
		
		puts "Imported from Flickr #{results.noun_count} nouns".green
	end
end