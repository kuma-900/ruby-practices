#!/usr/bin/env ruby
# frozen_string_literal: true

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

entries = Dir.entries('.')
visible_entries = remove_hidden_files(entries)
sorted_entries = visible_entries.sort

layout = layout_settings(sorted_entries)

(0...layout[:row_count]).each do |row|
  (0...layout[:column_count]).each do |col|
    index = row + col * layout[:row_count]
    print sorted_entries[index].ljust(layout[:max_width] + 4) if index < sorted_entries.size
  end
  puts
end
