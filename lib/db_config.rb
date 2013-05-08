module Throwdown
	module Database
		def self.init
			if (ENV['RACK_ENV'] == 'development')
				Bundler.require(:development)
				DataMapper::Logger.new($stdout, :debug)
				DataMapper.setup(:default, "sqlite://#{Dir.pwd}/throwdown.db")
				DataMapper::Model.raise_on_save_failure = true
			elsif (ENV['RACK_ENV']  == 'production')
				Bundler.require(:production)
				DataMapper.setup(:default, ENV['DATABASE_URL'])
			end

			DataMapper.finalize
			DataMapper.auto_upgrade!
		end
	end
end