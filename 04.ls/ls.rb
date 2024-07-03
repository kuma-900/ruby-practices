#!/usr/bin/env ruby
# frozen_string_literal: true

COLUMN_COUNT = 3

def remove_hidden_files(entries)
  entries.reject { |entry| entry.start_with?('.') }
end

def calculate_layout(entries)
  max_width = entries.map(&:length).max
  row_count = (entries.size / COLUMN_COUNT.to_f).ceil
  [max_width, row_count]
end

entries = Dir.entries('.')
visible_entries = remove_hidden_files(entries)
sorted_entries = visible_entries.sort

max_width, row_count = calculate_layout(sorted_entries)

(0...row_count).each do |row|
  (0...COLUMN_COUNT).each do |col|
    index = row + col * row_count
    print sorted_entries[index].ljust(max_width + 4) if index < sorted_entries.size
  end
  puts
end
