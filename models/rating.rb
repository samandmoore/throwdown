class Rating
	include DataMapper::Resource

	property :id, Serial
	property :score, Integer, :required => true

	belongs_to :noun
	belongs_to :adjective
	belongs_to :universe
end