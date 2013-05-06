class Scorer
	K = 32

	def create_matchup_result(adjective, ratingA, ratingB, winner)
		# who won?
		winner = ratingA unless ratingB.noun.id == winner;
		loser = ratingB unless ratingA.noun.id == winner;

		scores = compute_ratings(winner.score, loser.score)

		matchup = Matchup.new(
			:nounA => winner.noun,
			:nounB => loser.noun,
			:winner => winner.noun,
			:adjective => adjective,
			:nounA_delta => scores[0] - winner.score,
			:nounB_delta => scores[1] - loser.score
		)

		winner.score = scores[0]
		loser.score = scores[1]

		matchup
	end

	def compute_ratings(winnerScore, loserScore)
		winnerScore = winnerScore.to_f
		loserScore = loserScore.to_f

		# determine expectations
		expectationA = 1 / (1 + 10 ** ((loserScore - winnerScore) / 400))
		expectationB = 1 / (1 + 10 ** ((winnerScore - loserScore) / 400))

		# puts "expectation A: #{expectationA}"
		# puts "expectation B: #{expectationB}"

		# compute new ratings
		scoreA = winnerScore + K * (1 - expectationA)
		scoreB = loserScore + K * (0 - expectationB)

		[scoreA.to_i, scoreB.to_i]
	end

end