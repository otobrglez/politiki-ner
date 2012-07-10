require "spec_helper"

describe API do
	include Rack::Test::Methods
	def app() API; end

	describe "calls" do
		describe "GET /sentence_detector" do
			it "should break on missing text" do
				post "/sentence_detector"
				last_response.status.should_not == 200
				Oj.load(last_response.body)["error"].should =~ /missing/i
			end

			it "should return sentences" do
				post "/sentence_detector", { :text => "Danes je lep dan. Zanima me kaksen dan bo jutri? Tole je preizkus? \"Koliko je ura?\", ga je zanimalo?" }
				last_response.status.should == 201
				Oj.load(last_response.body)["sentences"].should include "Zanima me kaksen dan bo jutri?"
				Oj.load(last_response.body)["sentences"].size.should == 3
			end
		end

		describe "GET /tokenize" do
			it "should break if no text is sent!" do
				post "/tokenize"
				last_response.status.should_not == 200
				Oj.load(last_response.body)["error"].should =~ /missing/i
			end

			it "should return tokenized text" do
				post "/tokenize", { :text => "Danes je lep dan. Ali tokenizacija zares deluje? Že?" }
				last_response.status.should == 201
				tokens = Oj.load(last_response.body)["tokens"]
				tokens.size.should_not == 0
				tokens.should include "deluje"
			end
		end
	end

end
