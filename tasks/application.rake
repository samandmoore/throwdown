# Development server management
namespace :dev do
	desc 'Start in development mode'
	task :start => ['db:populate'] do
		system 'rackup -p 1234'
	end
end