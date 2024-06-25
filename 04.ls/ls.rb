#!/usr/bin/env ruby
# frozen_string_literal: true

entries = Dir.entries('.')

def remove_hidden_files(entries)
  entries.reject { |entry| entry.start_with?('.') }
end

visible_entries = remove_hidden_files(entries)

sorted_entries = visible_entries.sort

MAX_WIDTH = sorted_entries.map(&:length).max
COLUMN_COUNT = 3
ROW_COUNT = (sorted_entries.size / COLUMN_COUNT.to_f).ceil

(0...ROW_COUNT).each do |row|
  (0...COLUMN_COUNT).each do |col|
    index = row + col * ROW_COUNT
    print sorted_entries[index].ljust(MAX_WIDTH + 4) if index < sorted_entries.size
  end
  puts
end
