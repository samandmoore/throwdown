class Application < Sinatra::Base

	post '/ratings/new' do
		nounA = Noun.get(params[:nounA_id])
		nounB = Noun.get(params[:nounA_id])
		adjective = Adjective.get(params[:adjective_id])
		ratings = Rating.all(:adjective_id => adjective.id, :noun_id => [nounA.id, nounB.id])

		# compute the new ratings for nouns
		matchup = computeRatings(adjective, ratings, params[:winner_id])

		# update nouns' ratings
		matchup.save
		ratings[0].save
		ratings[1].save

		redirect '/'
	end

	# todo: move this to some object-oriented service thingy
	def computeRatings(adjective, ratings, winner)
		# constants
		k = 32

		# who won?
		resultA = ratings[0].noun.id == winner ? 1 : 0
		resultB = ratings[1].noun.id == winner ? 1 : 0

		# sort out the current ratings
		ratingA = ratings[0].score
		ratingB = ratings[1].score

		# determine expectations
		expectationA = 1 / (1 + 10 ** ((ratingB - ratingA) / 400))
		expectationB = 1 / (1 + 10 ** ((ratingA - ratingB) / 400))

		# compute new ratings
		ratingA = ratingA + k * (resultA - expectationA)
		ratingB = ratingB + k * (resultB - expectationB)

		matchup = Matchup.new(
			:nounA => ratings[0].noun,
			:nounB => ratings[1].noun,
			:winner => resultA == 1 ? ratings[0].noun : ratings[1].noun,
			:adjective => adjective,
			:nounA_delta => ratingA - ratings[0].score,
			:nounB_delta => ratingB - ratings[1].score
		)

		ratings[0].score = ratingA
		ratings[1].score = ratingB

		matchup
	end

end