#!/usr/bin/env ruby
# frozen_string_literal: true

require 'git'
require 'logger'
require 'amazing_print'

LOGGER = Logger.new('git-garbler.log', level: Logger::INFO)
at_exit { LOGGER.close }

if ARGV.size != 2
  puts 'Need two arguments:'
  puts ' 1. input folder name containing a Git repo to read from'
  puts ' 2. Output folder name to write the garbled new repo content'
  exit 1
end

if ARGV[0] == ARGV[1]
  puts 'Use different locations for the input and output'
  exit 1
end

input_folder = ARGV[0]
output_folder = ARGV[1]

if File.directory?(output_folder) && !Dir[File.join(output_folder, '**')].empty?
  puts "Error: The output folder '#{output_folder}' is not empty."
  puts 'Please provide an empty output folder.'
  exit 1
end

if File.file?(output_folder)
  puts "The given name '#{output_folder}' is a file, not a folder"
  exit 1
end

puts 'Trying to create output folder…'
begin
  Dir.mkdir(output_folder)
rescue Errno::EEXIST => e
  puts "Using existing outputfolder '#{output_folder}'."
end


input_git = Git.open(input_folder, log: LOGGER)

puts "Git repo to garble: #{input_git.repo} / #{input_git.dir}"

input_git.log.each { |l| puts l.sha }
