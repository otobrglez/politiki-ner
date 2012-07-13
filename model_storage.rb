# By Oto Brglez - <oto.brglez@opalab.com>

require "base64"
%w(dm-core dm-migrations dm-validations).each { |m| require m; }
require "java"

# DataMapper configuration
DataMapper::Logger.new("/dev/null", :debug)
DataMapper.setup(:default, 
	(ENV["RACK_ENV"] == "production") ? ENV["DATABASE_URL"] :
	'mysql://root@localhost/politiki_ner'
)

# Model definition
class Model
	include DataMapper::Resource
	property :id,   Serial
	property :name, String, :key => true
	property :body, Text
	validates_uniqueness_of :name
	validates_presence_of :name, :body
end

# Migrations
DataMapper.auto_upgrade!
DataMapper.finalize

class ModelStorage

	# Load model from database
	def self.load_model name
		model = Model.first(:name => name)
		raise "Missing model \"#{name}\" in database!" if model.nil?

		str = Base64.decode64(model.body).to_java_bytes
		java.io.ByteArrayInputStream.new(str)
	end

	# Save model to database
	def self.save_model_from_string name, str
		m = Model.new
		m.name, m.body = name, str
		m.save
	end

	# Save model from file
	def self.save_model_from_file name, path
		m = Model.new
		m.name, m.body = name, Base64.encode64(IO.read(path))
		m.save
	end
end

