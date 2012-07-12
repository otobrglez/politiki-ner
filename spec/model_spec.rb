require "spec_helper"

describe Model do

	describe "Model structure" do
		it "has some structure" do
			m = Model.new
			m.should respond_to :body
			m.should respond_to :name
		end
	end

end