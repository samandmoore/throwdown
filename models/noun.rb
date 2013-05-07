class Noun
	include DataMapper::Resource
	
	property :id, Serial
	property :name, String, :required => true, :length => 1..255
	property :created_at, DateTime, :default => DateTime.now

	property :image_url, String, :length => 1..2000, :required => true
	property :image_src, Enum[ :local, :flickr, :picasa, :s3, :azure ]

	has n, :ratings
	belongs_to :universe
end