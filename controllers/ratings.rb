class Application < Sinatra::Base

	post '/ratings/new' do
		nounA = Noun.get(params[:nounA_id])
		nounB = Noun.get(params[:nounB_id])
		adjective = Adjective.get(params[:adjective_id])

		ratingA = Rating.first(:adjective_id => adjective.id, :noun_id => nounA.id) || Rating.new(:adjective => adjective, :noun => nounA, :score => 1000)
		ratingB = Rating.first(:adjective_id => adjective.id, :noun_id => nounB.id) || Rating.new(:adjective => adjective, :noun => nounB, :score => 1000)

		# compute the new ratings for nouns
		matchup = computeRatings(adjective, ratingA, ratingB, params[:winner_id])

		# update nouns' ratings
		matchup.save
		ratingA.save
		ratingB.save

		redirect '/'
	end

	# todo: move this to some object-oriented service thingy
	def computeRatings(adjective, ratingA, ratingB, winner)
		# constants
		k = 32

		# who won?
		resultA = ratingA.noun.id == winner ? 1 : 0
		resultB = ratingB.noun.id == winner ? 1 : 0

		# sort out the current ratings
		scoreA = ratingA.score
		scoreB = ratingB.score

		# determine expectations
		expectationA = 1 / (1 + 10 ** ((scoreB - scoreA) / 400))
		expectationB = 1 / (1 + 10 ** ((scoreA - scoreB) / 400))

		# compute new ratings
		scoreA = scoreB + k * (resultA - expectationA)
		scoreB = scoreA + k * (resultB - expectationB)

		matchup = Matchup.new(
			:nounA => ratingA.noun,
			:nounB => ratingB.noun,
			:winner => resultA == 1 ? ratingA.noun : ratingB.noun,
			:adjective => adjective,
			:nounA_delta => scoreA - ratingA.score,
			:nounB_delta => scoreB - ratingB.score
		)

		ratingA.score = scoreA
		ratingB.score = scoreB

		matchup
	end

end