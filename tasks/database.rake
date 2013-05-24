namespace :db do
	task :environment do
		# models, require all models
		Dir[Throwdown::Root + '/models/*.rb'].each do |file|
			require file
		end

		# models loaded, configure db
		require_relative '../lib/db_config'
		Throwdown::Database.configure()
	end

	desc 'Auto-migrate the database (destroys data)'
	task :migrate => :environment do
		puts "Bootstrapping database (destroys data)...".yellow
		
		Throwdown::Database.init(true)
	end

	desc 'Auto-upgrade the database (preserves data)'
	task :upgrade => :environment do
		puts "Upgrading database (preserves data)...".yellow

		Throwdown::Database.init()
	end

	desc "Run all pending migrations, or up to specified migration"
	task :migrate_to, [:version] => [:upgrade, :load_migrations] do |t, args|
		require 'dm-migrations/migration_runner'
		if vers = args[:version] || ENV['VERSION']
			puts "=> Migrating up to version #{vers}"
			migrate_up!(vers)
		else
			puts "=> Migrating up"
			migrate_up!
		end
		puts "<= #{t.name} done"
	end

	desc "List migrations descending, showing which have been applied"
	task :migrations => :load_migrations do
		puts migrations.sort.reverse.map {|m| "#{m.position}  #{m.name}  #{m.needs_up? ? '' : 'APPLIED'}"}
	end

	task :load_migrations => :environment do
		require 'dm-migrations/migration_runner'
		Dir[Throwdown::Root + '/db/migrate/*.rb'].each do |migration|
			load migration
		end
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