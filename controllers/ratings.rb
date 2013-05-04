class Application < Sinatra::Base

	post '/ratings/new' do
		nounA = Noun.find(params[:nounA_id])
		nounB = Noun.find(params[:nounA_id])
		adjective = Adjective.find(params[:adjective_id])
		ratings = Rating.where(:adjective_id => adjective.id, :noun_id => [nounA.id, nounB.id])
		# load ratings for nouns for adjective

		# compute the new ratings for nouns
		# update nouns' ratings

		redirect '/'
	end

	def computeRating(ratings, winner)
		# constants
		K = 32

		# who won?
		sa = ratings[0].noun_id == winner ? 1 : 0
		sb = ratings[1].noun_id == winner ? 1 : 0

		# sort out the current ratings
		RA = ratings[0].score
		RB = ratings[1].score

		# determine expectations
		EA = 1 / (1 + pow(10, ((RB - RA) / 400)))
		EB = 1 / (1 + pow(10, ((RA - RB) / 400)))

		# compute new ratings
		RA = RA + K * (sa - EA)
		RB = RB + K * (sb - EB)

		ratings[0].score = RA
		ratings[1].score = RB
	end

end