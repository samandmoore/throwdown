class Application < Sinatra::Base

	post '/ratings/new' do
		nounA = Noun.find(params[:nounA_id])
		nounB = Noun.find(params[:nounA_id])
		adjective = Adjective.find(params[:adjective_id])
		ratings = Rating.where(:adjective_id => adjective.id, :noun_id => [nounA.id, nounB.id])

		# compute the new ratings for nouns
		computeRatings(ratings, params[:winner_id])

		# update nouns' ratings

		redirect '/'
	end

	# todo: move this to some object-oriented service thingy
	def computeRatings(ratings, winner)
		# constants
		k = 32

		# who won?
		resultA = ratings[0].noun_id == winner ? 1 : 0
		resultB = ratings[1].noun_id == winner ? 1 : 0

		# sort out the current ratings
		ratingA = ratings[0].score
		ratingB = ratings[1].score

		# determine expectations
		expectationA = 1 / (1 + pow(10, ((ratingB - ratingA) / 400)))
		expectationB = 1 / (1 + pow(10, ((ratingA - ratingB) / 400)))

		# compute new ratings
		ratingA = ratingA + k * (resultA - expectationA)
		ratingB = ratingB + k * (resultB - expectationB)

		ratings[0].score = ratingA
		ratings[1].score = ratingB
	end

end