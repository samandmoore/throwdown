module Throwdown
	module Bootstrapper
		def self.init(root)
			# models, require all models
			Dir[root + '/models/*.rb'].each do |file|
				require file
			end

			# models loaded, finalize db
			require_relative 'db_config'
			Throwdown::Database.init()

			# routes, require all controllers
			Dir[root + '/controllers/*.rb'].each do |file|
				require file
			end

			# html helpers
			require_relative 'html_helpers'
		end
	end
end