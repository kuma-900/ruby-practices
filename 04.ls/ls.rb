#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

COLUMN_COUNT = 3
OCTAL_LENGTH = 6
DATE_FORMAT = '%-m %e %H:%M'

FILE_TYPE_MAP = {
  '01' => 'p',
  '02' => 'c',
  '04' => 'd',
  '06' => 'b',
  '10' => '-',
  '12' => 'l',
  '14' => 's'
}.freeze

PERMISSION_MAP = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

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

def file_type_to_string(file_type_octal)
  FILE_TYPE_MAP[file_type_octal]
end

def permission_to_string(permission_octal)
  permission_octal.chars.map { |char| PERMISSION_MAP[char] }.join
end

def collect_file_details(entries)
  total_blocks = 0
  file_details = entries.map do |entry|
    file_stat = File.stat(entry)
    total_blocks += file_stat.blocks
    file_mode_octal = file_stat.mode.to_s(8).rjust(OCTAL_LENGTH, '0')

    file_type = file_type_to_string(file_mode_octal[0..1])
    file_permission = permission_to_string(file_mode_octal[-3..])
    nlink = file_stat.nlink
    owner_name = Etc.getpwuid(file_stat.uid).name
    group_name = Etc.getgrgid(file_stat.gid).name
    file_size = file_stat.size
    mtime = file_stat.mtime.strftime(DATE_FORMAT)

    ["#{file_type}#{file_permission}", nlink.to_s, owner_name, group_name, file_size.to_s, mtime, entry]
  end

  [total_blocks, file_details]
end

options = {}
opt = OptionParser.new

opt.on('-a') { options[:show_hidden] = true }
opt.on('-r') { options[:reverse] = true }
opt.on('-l') { options[:long_format] = true }

opt.parse!(ARGV)

entries = Dir.entries('.').sort
entries = remove_hidden_files(entries) unless options[:show_hidden]
ordered_entries = options[:reverse] ? entries.reverse : entries

if options[:long_format]
  total_blocks, file_details = collect_file_details(ordered_entries)

  puts "total #{total_blocks}"

  widths = file_details.transpose.map { |column| column.map(&:length).max }

  file_details.each do |file_detail|
    print file_detail[0].ljust(widths[0])
    print file_detail[1].rjust(widths[1] + 2)
    print file_detail[2].rjust(widths[2] + 1)
    print file_detail[3].rjust(widths[3] + 2)
    print file_detail[4].rjust(widths[4] + 2)
    print file_detail[5].rjust(widths[5] + 2)
    print ' '
    print file_detail[6].ljust(widths[6] + 2)
    puts
  end

else

  settings = layout_settings(ordered_entries)

  (0...settings[:row_count]).each do |row|
    (0...settings[:column_count]).each do |col|
      index = row + col * settings[:row_count]
      print ordered_entries[index].ljust(settings[:max_width] + 4) if index < ordered_entries.size
    end
    puts
  end

end
