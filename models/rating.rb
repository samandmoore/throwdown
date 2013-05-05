class Rating
	include DataMapper::Resource

	property :id, Serial
	property :score, Integer

	belongs_to :noun
	belongs_to :adjective
end