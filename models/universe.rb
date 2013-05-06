class Universe
	include DataMapper::Resource

	property :id, Serial
	property :name, String, :length => 1..255, :required => true

	has n, :ratings
	has n, :nouns
	has n, :matchups
	has n, :adjectives
end