require 'spec_helper'

describe Scorer do
	before do
		@scorer = Scorer.new()
	end

	describe "#compute_ratings" do
		it "returns properly adjusted scores" do
			scores = @scorer.compute_ratings(1000, 1000)
			scores[0].should eql 1016
			scores[1].should eql 984
		end
	end
end