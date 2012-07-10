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

path = "models/news-ner-person.raw"
@@sentence_model = SentenceModel.new(java.io.FileInputStream.new("models/si-sent.bin"))
@@tokenizer_model = TokenizerModel.new(java.io.FileInputStream.new("models/si-token.bin"));

def sentences(text)
	sentences_o = []
	(SentenceDetectorME.new(@@sentence_model).sentDetect(text)).each do |s| sentences_o << s; end
	sentences_o
end

def tokens(text)
	tokenized = []
	TokenizerME.new(@@tokenizer_model).tokenize(text).each do |s| tokenized << s; end
	tokenized
end

File.open(path,"r").each do |line|
	sentences(line).each do |sentence|
		puts tokens(sentence).join(" ")+"\n"
	end
	puts "\n"

end