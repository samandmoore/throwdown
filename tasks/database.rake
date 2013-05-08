namespace :db do
	desc 'Auto-migrate the database (destroys data)'
	task :migrate do
		puts "Bootstrapping database (destroys data)...".yellow
		
		# models, require all models
		Dir[Throwdown::Root + '/models/*.rb'].each do |file|
			require file
		end

		# models loaded, configure db
		require_relative '../lib/db_config'
		Throwdown::Database.configure()
		Throwdown::Database.init(true)
	end

	desc 'Auto-upgrade the database (preserves data)'
	task :upgrade do
		puts "Upgrading database (preserves data)...".yellow

				# models, require all models
		Dir[Throwdown::Root + '/models/*.rb'].each do |file|
			require file
		end

		# models loaded, configure db
		require_relative '../lib/db_config'
		Throwdown::Database.configure()
		Throwdown::Database.init()
	end

	desc 'Populate the database with default data'
	task :populate => [:upgrade] do
		require Throwdown::Root + '/lib/db_import'

		puts "Populating the database with default data".yellow

		db_importer = DbImport.new()
		db_importer.run()

		puts "Imported nouns and adjectives into database".green
	end
end