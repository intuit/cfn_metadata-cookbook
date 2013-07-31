require 'emeril/rake_tasks'
require 'foodcritic'
require 'rspec/core/rake_task'

Emeril::RakeTasks.new do |t|
  t.config[:logger]               = Logger.new(STDOUT)
  t.config[:publish_to_community] = false
  t.config[:publisher]            = nil
  t.config[:tag_prefix]           = false
end

FoodCritic::Rake::LintTask.new do |t|
  t.options = { :fail_tags => ['any'] }
end

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = "cookbooks/*/spec{,/*/**}/*_spec.rb"
  t.rspec_opts = %w(--color --format documentation)
end

task :default => [:foodcritic, :spec]
