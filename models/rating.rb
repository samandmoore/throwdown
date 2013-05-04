class Rating
	attr_accessor :score
	attr_accessor :noun_id
	attr_accessor :adjective_id
	attr_accessor :matchup_id

	def initialize(score, noun_id, adjective_id)
		@score = score
		@noun_id = noun_id
		@adjective_id = adjective_id
	end
end