namespace :db do
	desc 'Auto-migrate the database (destroys data)'
	task :migrate do
		puts "Bootstrapping database (destroys data)...".yellow
		
		Bundler.require(:development)
		DataMapper::Logger.new($stdout, :debug)
		DataMapper.setup(:default, "sqlite://#{Throwdown::Root}/throwdown.db")
		DataMapper::Model.raise_on_save_failure = true

		# models, require all models
		Dir[Throwdown::Root + '/models/*.rb'].each do |file|
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
		DataMapper.setup(:default, "sqlite://#{Throwdown::Root}/throwdown.db")
		DataMapper::Model.raise_on_save_failure = true

		# models, require all models
		Dir[Throwdown::Root + '/models/*.rb'].each do |file|
			require file
		end

		DataMapper.finalize
		DataMapper.auto_upgrade!
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