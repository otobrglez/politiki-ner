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

class API < Grape::API

	rescue_from :all
	error_format :json
	format :json
  	default_format :json

	post "sentence_detector" do
		throw "Missing \"text\" parameter to do sentence detection on." if params[:text].nil? or params[:text].empty?
		model = SentenceModel.new(java.io.FileInputStream.new("models/si-sent.bin"))
	
		sentences_o = []
		(SentenceDetectorME.new(model).sentDetect(params[:text])).each do |s| sentences_o << s; end

		{ :sentences => sentences_o }
	end

	post "tokenize" do
		throw "Missing \"text\" parameter to do tokenization on." if params[:text].nil? or params[:text].empty?
		model = TokenizerModel.new(java.io.FileInputStream.new("models/si-token.bin"));
		
		tokenized = []
		TokenizerME.new(model).tokenize(params[:text]).each do |s| tokenized << s; end

		{ :tokens => tokenized}
	end
end