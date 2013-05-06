class Matchup
	include DataMapper::Resource

	property :id, Serial
	property :created_at, DateTime, :default => DateTime.now
	
	property :nounA_delta, Integer, :required => true
	property :nounB_delta, Integer, :required => true

	belongs_to :adjective
	belongs_to :winner, 'Noun'
	belongs_to :nounA, 'Noun'
	belongs_to :nounB, 'Noun'
	belongs_to :universe
end