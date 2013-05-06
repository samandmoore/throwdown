class Noun
	include DataMapper::Resource
	
	property :id, Serial
	property :name, String, :required => true, :length => 1..255
	property :created_at, DateTime, :default => DateTime.now

	# TODO: add image_url
	# TODO: add image_src, enum (flickr, local, picasa, s3, azure)

	has n, :ratings
	belongs_to :universe
end