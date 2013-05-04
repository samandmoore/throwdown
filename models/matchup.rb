class Matchup
	include DataMapper::Resource

	property :id, Serial
	property :created_at, DateTime, :default => DateTime.now
	
	property :nounA_delta, Integer
	property :nounB_delta, Integer

	belongs_to :adjective
	belongs_to :winner, 'Noun'
	belongs_to :nounA, 'Noun'
	belongs_to :nounB, 'Noun'
end