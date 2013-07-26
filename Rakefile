require 'foodcritic'
require 'rspec/core/rake_task'

FoodCritic::Rake::LintTask.new do |t|
  t.options = { :fail_tags => ['any'] }
end

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = "cookbooks/*/spec{,/*/**}/*_spec.rb"
  t.rspec_opts = %w(--color --format documentation)
end

task :default => [:foodcritic, :spec]
