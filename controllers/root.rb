# Controller for routes from the root
class Application < Sinatra::Base

	# Root path
	get '/' do
		@universe = Universe.first(
			:name => 'Default'
		)

		noun_count = Noun.count(:universe => @universe)
		adj_count = Adjective.count(:universe => @universe)

		@nounA = Noun.first(
			:universe => @universe,
			:offset => rand(noun_count)
		)
		
		@nounB = Noun.first(
			:universe => @universe,
			:offset => rand(noun_count)
		)

		@adjective = Adjective.first(
			:universe => @universe,
			:offset => rand(adj_count)
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