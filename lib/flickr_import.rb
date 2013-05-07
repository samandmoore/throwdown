require 'flickraw'

class FlickrImport

	def initialize
		FlickRaw.api_key = 'cba6437762c0cd5e03f2e0ca7a3ee6db'
		FlickRaw.shared_secret = 'ed5abcbc44b92f65'
	end

	def run
		# get a list of tags, create adjectives for them
		# get a bunch of images for the tag, create nouns for them
	end
end