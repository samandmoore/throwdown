class DbImport
	def initialize
	end

	def run
		universe = Universe.first_or_create(
			:name => 'Default'
		)

		puts "Added `Default` universe to database".green

		[{:name => 'Josie', :image_url => '/images/josie.jpg'},
		{:name => 'Kacie', :image_url => '/images/kacie.jpg'},
		{:name => 'Tucker', :image_url => '/images/tucker.jpg'},
		{:name => 'Scout', :image_url => '/images/scout.jpg'}].each do |noun|
			Noun.first_or_create(
				:name => noun[:name],
				:image_url => noun[:image_url],
				:image_src => :local,
				:universe => universe
			)
			puts "Added `#{noun[:name]}` noun to database".green
		end

		['Brown', 'Blue', 'Black', 'White', 'Red'].each do |adj|
			Adjective.first_or_create(
				:name => adj,
				:universe => universe
			)
			puts "Added `#{adj}` adjective to database".green
		end
	end
end