class Matchup
	attr_accessor :id
	attr_accessor :nounA_id
	attr_accessor :nounB_id
	attr_accessor :adjective_id
	attr_accessor :winner_id
	attr_accessor :nounA_delta
	attr_accessor :nounB_delta

	def initialize(nounA_id, nounB_id, adjective_id, winner_id, nounA_delta, nounB_delta)
		@nounA_id = nounA_id
		@nounB_id = nounB_id
		@adjective_id = adjective_id
		@winner_id = winner_id
		@nounA_delta = nounA_delta
		@nounB_delta = nounB_delta
	end
end