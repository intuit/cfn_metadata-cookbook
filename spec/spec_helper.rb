require 'rubygems'
require 'bundler/setup'

libs = File.expand_path("../../libraries", __FILE__)

Dir.entries(libs).each do |r|
  require "#{libs}/#{r}" unless r =~ /^\..*$/
end

RSpec.configure do |config|
  #spec config
end
