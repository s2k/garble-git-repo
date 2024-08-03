# frozen_string_literal: true

require 'faker'

# This class provides various way to deal with random commits and
# provides freely hallucinated commit messages, file_contents & filenames
#
class CommitInventor

  # Generates commit message by taking a random verb in ()simple present and add
  # a faked company catch phrase
  def commit_message
    "#{Faker::Verb.simple_present} #{Faker::Company.catch_phrase}".capitalize
  end

  # Provides some random content
  #
  def content
    (1..rand(2..5)).map{
      Faker::Lorem.paragraph(sentence_count: rand(2..8))
    }.join("\n")
  end

  # Returns a random file name, accepts an argument to enter a folder name
  #
  def filename(ext: 'txt', folder: '.')
    Faker::File.file_name(ext: ext, dir: folder)
  end

  # A – more or less – random DateTime to be used as the commit date
  def datetime
    Faker::Time.between_dates from: '1066-10-14', to: '2982-12-31'
  end

  # Rearranges content
  # @line_shuffling_ratio gives the probability that the content of a singe line is shuffled.
  # @content_shuffling_ration is the probability of that the lines are shuffled
  #
  def rearrange_content(input, line_shuffling_ratio: 0.1, row_shuffling_ratio: 0.2)
    rearranged_lines = input.lines.map do |line|
      if rand < line_shuffling_ratio
        line.split(/\.\s/).shuffle.join('. ')
      else
        line
      end
    end
    rearranged_lines.shuffle! if rand < row_shuffling_ratio
    rearranged_lines.join("\n")
  end
end
