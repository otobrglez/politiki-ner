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
include_class "opennlp.tools.tokenize.SimpleTokenizer"
include_class "opennlp.tools.tokenize.TokenizerModel"
include_class "opennlp.tools.tokenize.TokenizerME"

#model_stream = java.io.FileInputStream.new("apache-opennlp/nlp-models/en-token.bin")
model_stream = java.io.FileInputStream.new("models/si-token.bin")
model = TokenizerModel.new(model_stream);
tokenizer = TokenizerME.new(model)

tokenizer.tokenize("Danes je lep dan. Tokenizacija deluje, to je vprašanje? To bi bilo fino.").each do |s|
	puts s
end