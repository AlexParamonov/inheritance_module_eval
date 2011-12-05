# encoding: utf-8
# GEMS
require "bundler/gem_tasks"

# SPECS
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end
#Rake::Task["spec"].execute
task :default => :spec