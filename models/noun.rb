class Noun
	include DataMapper::Resource
	
	property :id, Serial
	property :name, String
	property :created_at, DateTime, :default => DateTime.now

	has n, :ratings
end