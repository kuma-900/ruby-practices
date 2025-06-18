# frozen_string_literal: true

require_relative 'entry'
require_relative 'ls_options'

class LsFormatter
  COLUMN_COUNT = 3

  def initialize(entry_list, options)
    @entry_list = entry_list
    @options = options
  end

  def format
    @options.long_format? ? format_long : format_short
  end

  private

  def calculate_widths
    {
      nlink: @entry_list.map { |entry| entry.nlink.to_s.length }.max,
      owner_name: @entry_list.map { |entry| entry.owner_name.length }.max,
      group_name: @entry_list.map { |entry| entry.group_name.length }.max,
      file_size: @entry_list.map { |entry| entry.file_size.to_s.length }.max,
      mtime: @entry_list.map { |entry| entry.mtime.length }.max,
      file_name: @entry_list.map { |entry| entry.file_name.length }.max
    }
  end

  def format_short
    max_width = @entry_list.map { |entry| entry.file_name.length }.max
    row_count = (@entry_list.size / COLUMN_COUNT.to_f).ceil

    lines = (0...row_count).map do |row|
      (0...COLUMN_COUNT).map do |col|
        index = row + col * row_count
        @entry_list[index].file_name.ljust(max_width + 4) if index < @entry_list.size
      end.join
    end
    lines.join("\n")
  end

  def format_long
    widths = calculate_widths
    lines = []
    lines << "total #{@entry_list.sum(&:blocks)}"

    @entry_list.each do |entry|
      lines << [
        entry.file_type_and_permission,
        entry.nlink.to_s.rjust(widths[:nlink] + 2),
        entry.owner_name.rjust(widths[:owner_name] + 1),
        entry.group_name.rjust(widths[:group_name] + 2),
        entry.file_size.to_s.rjust(widths[:file_size] + 2),
        entry.mtime.rjust(widths[:mtime] + 2),
        ' ',
        entry.file_name.ljust(widths[:file_name] + 2)
      ].join
    end
    lines.join("\n")
  end
end
