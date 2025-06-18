# frozen_string_literal: true

require 'etc'

class Entry
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

  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
    @stat = File.stat(file_name)
  end

  def hidden?
    @file_name.start_with?('.')
  end

  def file_type_and_permission
    "#{file_type}#{permission}"
  end

  def nlink
    @stat.nlink
  end

  def owner_name
    Etc.getpwuid(@stat.uid).name
  end

  def group_name
    Etc.getgrgid(@stat.gid).name
  end

  def file_size
    @stat.size
  end

  def mtime
    @stat.mtime.strftime(DATE_FORMAT)
  end

  def blocks
    @stat.blocks
  end

  private

  def octal_mode
    @stat.mode.to_s(8).rjust(OCTAL_LENGTH, '0')
  end

  def file_type
    FILE_TYPE_MAP[octal_mode[0..1]]
  end

  def permission
    octal_mode[-3..].chars.map { |char| PERMISSION_MAP[char] }.join
  end
end
