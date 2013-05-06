class Application < Sinatra::Base

	post '/ratings/new' do
		nounA = Noun.get(params[:nounA_id])
		nounB = Noun.get(params[:nounB_id])
		adjective = Adjective.get(params[:adjective_id])

		ratingA = Rating.first(:adjective_id => adjective.id, :noun_id => nounA.id) || Rating.new(:adjective => adjective, :noun => nounA, :score => 1000, :universe_id => 1)
		ratingB = Rating.first(:adjective_id => adjective.id, :noun_id => nounB.id) || Rating.new(:adjective => adjective, :noun => nounB, :score => 1000, :universe_id => 1)

		# compute the new ratings for nouns
		scorer = Scorer.new()
		matchup = scorer.create_matchup_result(adjective, ratingA, ratingB, params[:winner_id])

		# update nouns' ratings
		matchup.save
		ratingA.save
		ratingB.save

		flash[:info] = "Rating recorded!"
		redirect '/'
	end

end