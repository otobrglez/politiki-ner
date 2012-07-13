require "bundler/setup"
require "rack/test"
require "oj"

require "java"
Dir["jars/*"].each { |jar| require jar }

require "api"
require "model_storage"