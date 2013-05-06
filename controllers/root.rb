# Controller for routes from the root
class Application < Sinatra::Base

	# Root path
	get '/' do
		@title = 'Home'

		@universe = Universe.first_or_create(
			:name => 'Default'
		)

		@nounA = Noun.first_or_create(
			:name => 'Laura',
			:universe => @universe
		)
		
		@nounB = Noun.first_or_create(
			:name => 'Sam',
			:universe => @universe
		)

		@adjective = Adjective.first_or_create(
			:name => 'Blue',
			:universe => @universe
		)

		haml :index
	end

	## Error Pages ##

	# 404 error
	not_found do
		@title = '404'
		@code = 404
		@message = 'Page not found'
		haml :error
	end

	# General error
	error do
		@title = '500'
		@code = 500
		@message = 'An unknown error has occurred'
		haml :error
	end
end