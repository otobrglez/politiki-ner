# By Oto Brglez - <oto.brglez@opalab.com> 

require 'bundler/setup'
require 'ruby-debug'
require 'pp'

# Java & jRuby
require 'java'
Dir["jars/*"].each { |jar| require jar }

# OpenNLP
include_class "opennlp.tools.util.Span"
include_class "opennlp.tools.sentdetect.SentenceModel"
include_class "opennlp.tools.sentdetect.SentenceDetectorME"

begin
	stream = java.io.FileInputStream.new("apache-opennlp/nlp-models/en-sent.bin")
	model = SentenceModel.new(stream)
	detector = SentenceDetectorME.new(model)
	
	sentences = detector.sentDetect("Today is a nice day. I love the day. My name is Oto and I'm from Maribor.")

	sentences.each do |s|
		puts s
	end

rescue Exception => e
	puts e.message
end
