# Controller for routes from the root
class Application < Sinatra::Base

	# Root path
	get '/' do
		@title = 'Home'
		# @nounA = Noun.new('Noun A')

		@adjective = 'blue'
		
		
		haml :index
	end

	## Error Pages ##

	# 404 error
	not_found do
		@title = '404'
		@code = 404
		@message = 'Page not found'
		erb :error
	end

	# General error
	error do
		@title = '500'
		@code = 500
		@message = 'An unknown error has occurred'
		erb :error
	end
end