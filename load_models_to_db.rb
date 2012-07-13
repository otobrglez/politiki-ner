require "model_storage"

%w(si-sent.bin si-token.bin si-ner.bin).each do |m|
	if ModelStorage.save_model_from_file m, "models/#{m}"
		puts "Model #{m} stored!"
	else
		puts "Failed storing model #{m}!"
	end
end


