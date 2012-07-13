require "spec_helper"

describe Model do

	describe "Model structure" do
		it "has some structure" do
			m = Model.new
			m.should respond_to :body, :name
		end

		it "can store data" do
			Model.all.destroy

			m = ModelStorage.save_model_from_file "si-sent.bin", "models/si-sent.bin"
			m.should be_true
		end

		it "can retrive model" do
			Model.first(:name => "si-sent.bin").should_not be_nil
		end
	end

	describe "Storing and loading model" do

		it "can do this" do
			fis_1 = java.io.FileInputStream.new	"models/si-sent.bin"
			fis_2 = ModelStorage.load_model 	"si-sent.bin"
			
			fis_1.should_not be_nil
			fis_2.should_not be_nil
		end

		it "should store and retrive" do
			sm = SentenceModel.new java.io.FileInputStream.new("models/si-sent.bin")
			sm.get_language.should == "si"

			sm2 = SentenceModel.new ModelStorage.load_model "si-sent.bin"
			sm2.get_language.should == "si"

			sm.get_version.should == sm2.get_version
		end
	end

end