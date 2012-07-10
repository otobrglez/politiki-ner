# By Oto Brglez - <oto.brglez@opalab.com>
require 'bundler/setup'
require 'grape'

# jRuby & Java Deps...
require 'java'
Dir["jars/*"].each { |jar| require jar }

# OpenNLP
include_class "opennlp.tools.util.Span"
include_class "opennlp.tools.sentdetect.SentenceModel"
include_class "opennlp.tools.sentdetect.SentenceDetectorME"
include_class "opennlp.tools.tokenize.TokenizerModel"
include_class "opennlp.tools.tokenize.TokenizerME"
include_class "opennlp.tools.namefind.NameFinderME"
include_class "opennlp.tools.namefind.TokenNameFinderModel"

@@sentence_model = SentenceModel.new(java.io.FileInputStream.new("models/si-sent.bin"))
@@tokenizer_model = TokenizerModel.new(java.io.FileInputStream.new("models/si-token.bin"))
@@tnf_model = TokenNameFinderModel.new(java.io.FileInputStream.new("models/si-ner.bin"))

class API < Grape::API

	rescue_from :all
	error_format :json
	format :json
  	default_format :json

  	helpers do
	  	def sentences text
			(SentenceDetectorME.new(@@sentence_model).sentDetect(text)).collect { |s| s.to_s }
	  	end

	  	def tokenizer
	  		(TokenizerME.new(@@tokenizer_model))
	  	end

	  	def tokens text
			tokenizer.tokenize(text).collect { |s| s.to_s }
	  	end

	  	def name_finder
	  		NameFinderME.new(@@tnf_model)
	  	end
  	end

	post "sentence_detector" do
		throw "Missing \"text\" parameter to do sentence detection on." if params[:text].nil? or params[:text].empty?
		{ :sentences => sentences(params[:text]) }
	end

	post "tokenize" do
		throw "Missing \"text\" parameter to do tokenization on." if params[:text].nil? or params[:text].empty?
		{ :tokens => tokens(params[:text]) }
	end

	post "ner" do
		throw "Missing \"text\" parameter to do ner on." if params[:text].nil? or params[:text].empty?
		
		sentences_list_out = []
		entities = {}

		sentences_list = sentences(params[:text])
		sentences_list.each_with_index do |s,s_i|
			tokens_list = tokens(s)
			
			pom = name_finder.find(tokens_list.to_java(:string))
			pom.each do |i|
				start_i, end_i, length, type = i.getStart, i.getEnd, i.length, i.getType

				entities[type.to_sym] = [] if entities[type.to_sym].nil?
				entities[type.to_sym] << tokens_list[start_i .. (end_i-1)].join(" ")
				entities[type.to_sym].uniq!

				tokens_list[start_i] = "<a href=\"##{type}\">#{tokens_list[start_i]}"
				tokens_list[end_i-1] = "#{tokens_list[end_i-1]}</a>"	
			end
			
			# TODO: Detokenize
			# URL https://github.com/dakrone/clojure-opennlp/blob/master/models/english-detokenizer.xml
			sentences_list_out << tokens_list.join(" ") #.gsub(/\s+/, "").strip
			name_finder.clearAdaptiveData()
		end

		{
			:text => sentences_list_out,
			:entities => entities
		}
	end
end