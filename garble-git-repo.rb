#!/usr/bin/env ruby
# frozen_string_literal: true

require 'amazing_print'
require_relative 'commit_inventor'

INITIAL_COMMIT_COUNT  = rand((5..11))

WORKING_ORIGINAL_REPO = 'original_repo'
WORKING_OUTPUT_FOLDER = 'garbled_repo'

class GitCommitError < RuntimeError; end

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

puts "Reading input from: `#{input_folder}`"

original_commits = Dir.chdir(input_folder) { `git log --format="%H"`.lines.map(&:strip) }

puts 'Original commit hashes:'
ap original_commits

# Create two sub folders:
#  1. To store a clone the input repository and read from that folder while iterating over the commits
#  2. the 'real' output folder to store the garbled repository

working_orig   = File.join(output_folder, WORKING_ORIGINAL_REPO)
working_output = File.join(output_folder, WORKING_OUTPUT_FOLDER)
Dir.mkdir(working_orig)
Dir.mkdir(working_output)

# Initialise a git repo in working_output
Dir.chdir(working_output) do
  res = `git init`
  puts 'Initialising output git repo: '
  puts res
end

# Clone input Git repo into working_orig
Dir.chdir(working_orig) do
  res = `git clone #{input_folder}`
  puts 'Cloning input repo:'
  puts res
end

generator = CommitInventor.new

# Write some noise commits (adding files) to output repo
Dir.chdir(working_output) do |arg|
  puts "In folder #{Dir.pwd}… (arg = #{arg})"
  INITIAL_COMMIT_COUNT.times do
    fn = generator.filename
    puts "Generated file name: #{fn}"
    File.open(fn, 'w') { |f| f.puts generator.content }
    puts 'Adding/Commiting changes…' if ENV['DEBUG']
    res = `git add -A`
    puts res if ENV['DEBUG']
    author_date = generator.datetime
    commit_date = generator.datetime
    puts "Author date   : '#{author_date}'  /  Committer date: '#{commit_date}'" if ENV['DEBUG']
    cmd = "GIT_COMMITTER_DATE=\"#{commit_date}\" git commit -m \"#{generator.commit_message}\" --date \"#{generator.datetime}\""
    puts "CMD: #{cmd}" if ENV['DEBUG']
    res = `#{cmd}`
    abort "AAAAAAAA" if $? != 0
    puts "*"*80
    puts "RESULT: ", res
    puts '*' * 80 if ENV['DEBUG']
    puts "RESULT: #{res}" if ENV['DEBUG']
  end
end
