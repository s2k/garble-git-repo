#!/usr/bin/env ruby
# frozen_string_literal: true

require 'amazing_print'
require_relative 'commit_inventor'

RANDOM_COMMITS_RANGE  = (7..13)
INITIAL_COMMIT_COUNT  = 250 #rand((5..11))

WORKING_ORIGINAL_REPO = 'original_repo'
WORKING_OUTPUT_FOLDER = 'garbled_repo'


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

input_folder  = File.expand_path(ARGV[0])
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
  puts "Using existing output folder '#{output_folder}'."
end

