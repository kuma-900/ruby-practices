#!/usr/bin/env ruby
# frozen_string_literal: true

entries = Dir.entries('.')

def remove_hidden_files(entries)
  entries.reject { |entry| entry.start_with?('.') }
end

def sort_entries(entries)
  entries.sort
end

visible_entries = remove_hidden_files(entries)

sorted_entries = sort_entries(visible_entries)

max_width = sorted_entries.map(&:length).max
row_count = (sorted_entries.size / 3.0).ceil
column_count = 3

(0...row_count).each do |row|
  (0...column_count).each do |col|
    index = row + col * row_count
    print sorted_entries[index].ljust(max_width + 4) if index < sorted_entries.size
  end
  puts
end
