require 'flickraw'

class FlickrImport

	def initialize
		FlickRaw.api_key = 'cba6437762c0cd5e03f2e0ca7a3ee6db'
		FlickRaw.shared_secret = 'ed5abcbc44b92f65'
	end

	def run
		results = { :noun_count => 0, :adj_count => 0 }

		photos = flickr.photos.getRecent()

		photos.each do |photo|
			info = flickr.photos.getInfo(:photo_id => photo.id, :secret => photo.secret)
			Noun.first_or_create(
				:name => info.title.empty? ? 'flickr: no desc' : info.title,
				:image_url => FlickRaw.url_short_m(info),
				:image_src => :flickr,
				:universe_id => 1
			)
			puts "imported photo from flickr: #{info.description}".green
			results[:noun_count] = results[:noun_count] + 1
		end

		results
	end
end