require "spec_helper"

describe API do
	include Rack::Test::Methods
	def app() API; end

	describe "calls" do
		describe "POST /sentence_detector" do
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

		describe "POST /tokenize" do
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

		describe "POST /ner" do
			it "should break if no text is present" do
				post "/ner"
				last_response.status.should_not == 200
				Oj.load(last_response.body)["error"].should =~ /missing/i
			end

			it "should extract parties" do
				post '/ner', {
					:text => "Borut Pahor, predsednik SD je v pogovoru za Radio Ognjišče napovedal,
					da bo svojo odločitev o kandidaturi za predsednika republike sporočil junija.
					Predsednik stranke SDS, Janez Janša je bil danes v Mariboru.
					Kadar zaseda stranka SD in Borut Pahor, potem Janez Janša ni vesel."
				}

				last_response.status.should == 201
				out = Oj.load(last_response.body)

				out["text"].first.should =~ /\#person/
				out["text"].first.should =~ /\#party/
				
				out["entities"]["person"].should include "Borut Pahor"
				out["entities"]["person"].should include "Janez Janša"

			end
		end
	end

end
