# frozen_string_literal: true
require 'rake/testtask'

task :default do
  puts `rake -T`
end

task :run do
  sh 'rerun "rackup -p 9000"'
end

Rake::TestTask.new(:spec) do |t|
  # sh 'rackup -D -p 9000'
  t.pattern = 'spec/*_spec.rb'
  t.warning = false
end
