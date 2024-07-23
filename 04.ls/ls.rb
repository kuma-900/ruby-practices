#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN_COUNT = 3

def remove_hidden_files(entries)
  entries.reject { |entry| entry.start_with?('.') }
end

def layout_settings(entries)
  max_width = entries.map(&:length).max
  row_count = (entries.size / COLUMN_COUNT.to_f).ceil
  {
    max_width:,
    row_count:,
    column_count: COLUMN_COUNT
  }
end

options = {}
opt = OptionParser.new

opt.on('-a') { options[:show_hidden] = true }
opt.on('-r') { options[:reverse] = true }

opt.parse!(ARGV)

entries = Dir.entries('.').sort
entries = remove_hidden_files(entries) unless options[:show_hidden]
entries = options[:reverse] ? entries.reverse : entries

settings = layout_settings(entries)

(0...settings[:row_count]).each do |row|
  (0...settings[:column_count]).each do |col|
    index = row + col * settings[:row_count]
    print entries[index].ljust(settings[:max_width] + 4) if index < entries.size
  end
  puts
end
