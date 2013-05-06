class Adjective
	include DataMapper::Resource

	property :id, Serial
	property :name, String, :required => true, :length => 1..255
	property :created_at, DateTime, :default => DateTime.now

	has n, :ratings
	belongs_to :universe
end