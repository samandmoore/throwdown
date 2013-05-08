require File.expand_path("../../lib/flickr_import", __FILE__)

namespace :import do
	desc 'Import some data from flickr'
	task :flickr => ['db:upgrade', 'db:populate'] do

		puts "Starting import from Flickr".yellow
		
		flickr_importer = FlickrImport.new()
		results = flickr_importer.run()

		puts "Imported from Flickr #{results[:nount_count]} nouns".green
	end
end