#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

options = {}
opt = OptionParser.new

opt.on('-l') { options[:line] = true }
opt.on('-w') { options[:word] = true }
opt.on('-c') { options[:byte] = true }

opt.parse!(ARGV)

options = { line: true, word: true, byte: true } if options.empty?

def process_content(content)
  {
    line: content.count("\n"),
    word: content.split(/\s+/).count,
    byte: content.bytesize
  }
end

def format_output(result, options, filename = nil)
  output = []
  output << result[:line] if options[:line]
  output << result[:word] if options[:word]
  output << result[:byte] if options[:byte]

  formatted_output = output.map { |count| count.to_s.rjust(8) }.join
  filename_output = filename.nil? ? '' : " #{filename}"
  puts "#{formatted_output}#{filename_output}"
end

totals = { line: 0, word: 0, byte: 0 }
files = ARGV.empty? ? [nil] : ARGV

files.each do |filename|
  content = filename ? File.read(filename) : $stdin.read
  result = process_content(content)
  format_output(result, options, filename)
  totals.merge!(result) { |_, a, b| a + b } if files.size > 1
end

format_output(totals, options, 'total') if files.size > 1
